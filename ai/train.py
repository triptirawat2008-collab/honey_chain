import tensorflow as tf
from tensorflow.keras import layers, models
from tensorflow.keras.applications import MobileNetV2
from pathlib import Path

# =========================
# SETTINGS
# =========================

DATASET_DIR = Path(__file__).resolve().parent / "dataset"

IMG_SIZE = (224, 224)
BATCH_SIZE = 16

INITIAL_EPOCHS = 5
FINE_TUNE_EPOCHS = 3

MODEL_PATH = Path(__file__).resolve().parent / "bee_disease_model.keras"


# =========================
# LOAD DATA
# =========================

train_dataset = tf.keras.utils.image_dataset_from_directory(
    DATASET_DIR / "train",
    image_size=IMG_SIZE,
    batch_size=BATCH_SIZE,
    label_mode="binary",
    shuffle=True,
    seed=42
)

validation_dataset = tf.keras.utils.image_dataset_from_directory(
    DATASET_DIR / "validation",
    image_size=IMG_SIZE,
    batch_size=BATCH_SIZE,
    label_mode="binary",
    shuffle=False
)

print("Classes:", train_dataset.class_names)

AUTOTUNE = tf.data.AUTOTUNE

train_dataset = train_dataset.prefetch(AUTOTUNE)
validation_dataset = validation_dataset.prefetch(AUTOTUNE)


# =========================
# MOBILE NET V2
# =========================

base_model = MobileNetV2(
    input_shape=(224, 224, 3),
    include_top=False,
    weights="imagenet"
)

base_model.trainable = False


# =========================
# BUILD MODEL
# =========================

model = models.Sequential([
    layers.Input(shape=(224, 224, 3)),

    layers.Rescaling(
        1.0 / 127.5,
        offset=-1
    ),

    base_model,

    layers.GlobalAveragePooling2D(),

    layers.Dropout(0.2),

    layers.Dense(1, activation="sigmoid")
])


# =========================
# INITIAL TRAINING
# =========================

model.compile(
    optimizer="adam",
    loss="binary_crossentropy",
    metrics=["accuracy"]
)

print()
print("====================================")
print("INITIAL TRAINING")
print("====================================")

model.fit(
    train_dataset,
    validation_data=validation_dataset,
    epochs=INITIAL_EPOCHS
)


# =========================
# LIGHT FINE-TUNING
# =========================

print()
print("====================================")
print("LIGHT FINE-TUNING")
print("====================================")

# Unfreeze the MobileNetV2 model
base_model.trainable = True

# Freeze everything except the last 20 layers
for layer in base_model.layers[:-20]:
    layer.trainable = False

print("Trainable MobileNetV2 layers: last 20")


# Use a very small learning rate
model.compile(
    optimizer=tf.keras.optimizers.Adam(
        learning_rate=0.00001
    ),
    loss="binary_crossentropy",
    metrics=["accuracy"]
)


model.fit(
    train_dataset,
    validation_data=validation_dataset,
    epochs=FINE_TUNE_EPOCHS
)


# =========================
# SAVE MODEL
# =========================

model.save(MODEL_PATH)

print()
print("====================================")
print("TRAINING COMPLETE")
print("====================================")

print()
print("Model saved to:")
print(MODEL_PATH)