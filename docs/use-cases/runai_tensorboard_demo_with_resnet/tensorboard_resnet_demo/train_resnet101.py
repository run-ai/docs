import numpy as np
import matplotlib.pylab as plt
import tensorflow as tf
import datetime

tb_dir = "/home/jovyan/work/tensorboard_logs"
project_name = 'resnet101'
model_path = '/home/jovyan/work/projects/tensorboard_resnet_demo/resnet101'

data_root = tf.keras.utils.get_file(
    'flower_photos',
    'https://storage.googleapis.com/download.tensorflow.org/example_images/flower_photos.tgz',
    cache_dir='./',
    untar=True)

NUM_EPOCHS = 5
batch_size = 32
img_height = 224
img_width = 224

train_ds = tf.keras.utils.image_dataset_from_directory(
  str(data_root),
  validation_split=0.2,
  subset="training",
  seed=123,
  image_size=(img_height, img_width),
  batch_size=batch_size
)



val_ds = tf.keras.utils.image_dataset_from_directory(
  str(data_root),
  validation_split=0.2,
  subset="validation",
  seed=123,
  image_size=(img_height, img_width),
  batch_size=batch_size
)

class_names = np.array(train_ds.class_names)
print(class_names)

normalization_layer = tf.keras.layers.Rescaling(1./255)
train_ds = train_ds.map(lambda x, y: (normalization_layer(x), y)) # Where x—images, y—labels.
val_ds = val_ds.map(lambda x, y: (normalization_layer(x), y)) # Where x—images, y—labels.

AUTOTUNE = tf.data.AUTOTUNE
train_ds = train_ds.cache().prefetch(buffer_size=AUTOTUNE)
val_ds = val_ds.cache().prefetch(buffer_size=AUTOTUNE)

num_classes = len(class_names)

model = tf.keras.applications.resnet.ResNet101(
    include_top=True,
    weights=None,
    input_shape=(224, 224, 3,),
    classes=num_classes,
    classifier_activation='softmax',
    pooling='avg',
    )

model.compile(
  optimizer=tf.keras.optimizers.Adam(),
  loss=tf.keras.losses.SparseCategoricalCrossentropy(),
  metrics=['sparse_categorical_accuracy'])

log_dir = log_dir = f"{tb_dir}/{project_name}/{datetime.datetime.now().strftime('%Y%m%d-%H%M%S')}"

tensorboard_callback = tf.keras.callbacks.TensorBoard(
    log_dir=log_dir,
    histogram_freq=1)

history = model.fit(train_ds,
                    validation_data=val_ds,
                    epochs=NUM_EPOCHS,
                    callbacks=[tensorboard_callback])

model.save(model_path)
    
