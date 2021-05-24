import os
import subprocess
import sys
import time

import keras
import numpy as np
from PIL import Image

# the total GPU memory available
if "RUNAI_GPU_MEMORY_MIB" in os.environ:
    TOTAL_MEMORY = int(os.getenv("RUNAI_GPU_MEMORY_MIB"))
else:
    TOTAL_MEMORY = int(subprocess.check_output('nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits --id=0', shell=True)) # in MiB

# the needed GPU memory in order to run this model with batch size 64
# this is not precise and is the amount of GPU memory in the on-prem server
NEEDED_MEMORY = 10490 # (~11GB) in MiB

FRACTION = TOTAL_MEMORY / NEEDED_MEMORY

GLOBAL_BATCH_SIZE = 256
MAX_GPU_BATCH_SIZE = 64
IMAGE_SIZE = 224
EPOCHS = 100

if "EPOCHS" in os.environ:
    EPOCHS = int(os.environ["EPOCHS"])

MAX_GPU_BATCH_SIZE = int(min(FRACTION * MAX_GPU_BATCH_SIZE, MAX_GPU_BATCH_SIZE))
IMAGE_SIZE = max(int(min(FRACTION * IMAGE_SIZE, IMAGE_SIZE)), 32) # image size must be at least 32

# if specified in command line

if len(sys.argv) > 1:
    GLOBAL_BATCH_SIZE = int(sys.argv[1])

if len(sys.argv) > 2:
    MAX_GPU_BATCH_SIZE = int(sys.argv[2])

if len(sys.argv) > 3:
    IMAGE_SIZE = int(sys.argv[3])

print("Total GPU memory: %d MiB (~%d%% of needed)" % (TOTAL_MEMORY, FRACTION * 100))
print("Global batch size: %d" % GLOBAL_BATCH_SIZE)
print("Max GPU batch size: %d" % MAX_GPU_BATCH_SIZE)
print("Image size: %d" % IMAGE_SIZE)
print("Using " + str(EPOCHS) + " number of epochs")

import runai.elastic.keras

runai.elastic.keras.init(global_batch_size=GLOBAL_BATCH_SIZE, max_gpu_batch_size=MAX_GPU_BATCH_SIZE)

print("Batch size: %d" % runai.elastic.batch_size)

REPORTER = False

try:
    if os.getenv("RUNAI_REPORT") == "1":
        import runai.reporter
        import runai.reporter.keras

        if "reporterGatewayURL" in os.environ and "podUUID" in os.environ:
            print("Using Run:AI k8s reporting mechanism")
            runai.reporter.keras.autolog()
            REPORTER = True
except ImportError: pass

def resize_images(src, shape):
    resized = [Image.fromarray(img).resize(size=shape) for img in src]
    return np.stack(resized)

def load_cifar10_data():
    path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'cifar-10')

    num_train_samples = 50000

    x_train = np.empty((num_train_samples, 3, 32, 32), dtype='uint8')
    y_train = np.empty((num_train_samples,), dtype='uint8')

    for i in range(1, 6):
        fpath = os.path.join(path, 'data_batch_' + str(i))
        (x_train[(i - 1) * 10000: i * 10000, :, :, :],
         y_train[(i - 1) * 10000: i * 10000]) = keras.datasets.cifar.load_batch(fpath)

    fpath = os.path.join(path, 'test_batch')
    x_test, y_test = keras.datasets.cifar.load_batch(fpath)

    y_train = np.reshape(y_train, (len(y_train), 1))
    y_test = np.reshape(y_test, (len(y_test), 1))

    if keras.backend.image_data_format() == 'channels_last':
        x_train = x_train.transpose(0, 2, 3, 1)
        x_test = x_test.transpose(0, 2, 3, 1)

    return (x_train, y_train), (x_test, y_test)

def cifar10_data(train_samples, test_samples, num_classes, trg_image_dim_size):
    (x_train, y_train), (x_test, y_test) = load_cifar10_data()
    print('Loaded train samples')

    x_train = x_train[:train_samples]
    y_train = y_train[:train_samples]

    x_test = x_test[:test_samples]
    y_test = y_test[:test_samples]

    x_train = resize_images(x_train, (trg_image_dim_size, trg_image_dim_size))
    x_test = resize_images(x_test, (trg_image_dim_size, trg_image_dim_size))

    y_train = np.clip(y_train, None, num_classes - 1)
    y_test = np.clip(y_test, None, num_classes - 1)
    y_train = keras.utils.to_categorical(y_train, num_classes)
    y_test = keras.utils.to_categorical(y_test, num_classes)

    print('Preprocessed train samples')
    print('X train shape: %s' % str(x_train.shape))
    print('Y train shape: %s' % str(y_train.shape))
    print('X test shape: %s' % str(x_test.shape))
    print('Y test shape: %s' % str(y_test.shape))

    return (x_train, y_train), (x_test, y_test)

class StepTimeReporter(keras.callbacks.Callback):
    def on_batch_begin(self, batch, logs={}):
        self.batch_start = time.time()

    def on_batch_end(self, batch, logs={}):
        print(' >> Step %d took %g sec' % (batch, time.time() - self.batch_start))

    def on_epoch_begin(self, epoch, logs=None):
        self.epoch_start = time.time()

    def on_epoch_end(self, epoch, logs=None):
        print(' >> Epoch %d took %g sec' % (epoch, time.time() - self.epoch_start))

def report(msg):
    print(msg)
    if REPORTER:
        runai.reporter.reportParameter("state", msg)

def main():
    report("Loading data")
    (x_train, y_train), (x_test, y_test) = cifar10_data(
        train_samples=5000,
        test_samples=1000,
        num_classes=10,
        trg_image_dim_size=IMAGE_SIZE,
    )

    report("Building model")
    model = keras.applications.vgg19.VGG19(
        input_shape=x_train[0].shape,
        include_top=True,
        weights=None,
        input_tensor=None,
        pooling=None,
        classes=10)

    report("Wrapping model with Run:AI elasticity")
    model = runai.elastic.keras.models.Model(model)

    model.compile(loss='categorical_crossentropy',
                  optimizer=keras.optimizers.SGD(lr=1e-3),
                  metrics=['accuracy'])

    report("Training model")
    model.fit(x_train, y_train,
              batch_size=runai.elastic.batch_size,
              epochs=EPOCHS,
              validation_data=(x_test, y_test),
              shuffle=False,
              verbose=runai.elastic.master,
              callbacks=[StepTimeReporter()] if runai.elastic.master else [])

    report("Done")

if __name__ == "__main__":
    main()
