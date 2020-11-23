from __future__ import print_function

import keras
from keras.models import Sequential
from keras.layers import Dense, Dropout
from keras.callbacks import ModelCheckpoint
from keras.callbacks import TensorBoard

import os
import datetime

checkpoints_file = "weights.best.hdf5"
log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")


NUM_CLASSES = 10
BATCH_SIZE = 128
EPOCHS = 100
LEARNING_RATE = 1.0

if "BATCH_SIZE" in os.environ:
    BATCH_SIZE = int(os.environ["BATCH_SIZE"])

if "EPOCHS" in os.environ:
    EPOCHS = int(os.environ["EPOCHS"])

if "LEARNING_RATE" in os.environ:
    LEARNING_RATE = float(os.environ["LEARNING_RATE"])

print("********")
print("Using " + str(EPOCHS) + " number of epochs")
print("Using batch size " + str(BATCH_SIZE))
print("Using learning rate " + str(LEARNING_RATE))
print("********")


(x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()

x_train = x_train.reshape(60000, 784)
x_test = x_test.reshape(10000, 784)
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255

y_train = keras.utils.to_categorical(y_train, NUM_CLASSES)
y_test = keras.utils.to_categorical(y_test, NUM_CLASSES)

model = Sequential()
model.add(Dense(512, activation='relu', input_shape=(784,)))
model.add(Dropout(0.2))
model.add(Dense(512, activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(NUM_CLASSES, activation='softmax'))

# load weights
if os.path.isfile(checkpoints_file):
    print("loading checkpoint file: " + checkpoints_file)
    model.load_weights(checkpoints_file)

model.compile(
    loss='categorical_crossentropy',
    optimizer=keras.optimizers.Adadelta(lr=LEARNING_RATE),
    metrics=['accuracy']
)

# register a 'save checkpoints' callback. Default is every epoch
checkpoint_callback = ModelCheckpoint(
    checkpoints_file, monitor='val_acc', 
    verbose=1, save_best_only=True, mode='max')

# Alternatively, save ALL checkpoints.
#   filepath="checkpoints/weights-improvement-{epoch:02d}-{val_acc:.2f}.hdf5"
#   checkpoint = ModelCheckpoint(filepath, monitor='val_acc', verbose=1, save_best_only=True, mode='max')

# Allow logs to be read from TensorBoard
tensorboard_callback = TensorBoard(log_dir=log_dir, histogram_freq=1)

model.fit(x_train, y_train,
        batch_size=BATCH_SIZE,
        epochs=EPOCHS,
        validation_data=(x_test, y_test),
        callbacks=[checkpoint_callback, tensorboard_callback])

score = model.evaluate(x_test, y_test)

print('Test loss:', score[0])
print('Test accuracy:', score[1])
