import tensorflow as tf
import numpy as np
from pathlib import Path

# =========================
# PATHS
# =========================

BASE_DIR = Path(__file__).resolve().parent

MODEL_PATH = BASE_DIR / "bee_disease_model.keras"
TEST_DIR = BASE_DIR / "dataset" / "test"

IMG_SIZE = (224, 224)
BATCH_SIZE = 16


# =========================
# LOAD MODEL
# =========================

print("Loading model...")

model = tf.keras.models.load_model(MODEL_PATH)

print("Model loaded successfully.")


# =========================
# LOAD TEST DATA
# =========================

test_dataset = tf.keras.utils.image_dataset_from_directory(
    TEST_DIR,
    image_size=IMG_SIZE,
    batch_size=BATCH_SIZE,
    label_mode="binary",
    shuffle=False
)

class_names = test_dataset.class_names

print()
print("Classes:", class_names)
print("Testing images:", sum(1 for _ in test_dataset.unbatch()))


# =========================
# GET PREDICTIONS
# =========================

print()
print("Running test...")

predictions = model.predict(test_dataset, verbose=1)

# Convert probabilities to 0 or 1
predicted_labels = (predictions >= 0.5).astype(int).flatten()

# Get actual labels
actual_labels = np.concatenate([
    labels.numpy().flatten()
    for _, labels in test_dataset
])


# =========================
# CALCULATE METRICS
# =========================

true_positive = np.sum(
    (actual_labels == 1) & (predicted_labels == 1)
)

true_negative = np.sum(
    (actual_labels == 0) & (predicted_labels == 0)
)

false_positive = np.sum(
    (actual_labels == 0) & (predicted_labels == 1)
)

false_negative = np.sum(
    (actual_labels == 1) & (predicted_labels == 0)
)


total = len(actual_labels)

accuracy = (true_positive + true_negative) / total

precision = (
    true_positive / (true_positive + false_positive)
    if (true_positive + false_positive) > 0
    else 0
)

recall = (
    true_positive / (true_positive + false_negative)
    if (true_positive + false_negative) > 0
    else 0
)

f1 = (
    2 * precision * recall / (precision + recall)
    if (precision + recall) > 0
    else 0
)


# =========================
# RESULTS
# =========================

print()
print("====================================")
print("TEST RESULTS")
print("====================================")

print()
print(f"Accuracy : {accuracy * 100:.2f}%")
print(f"Precision: {precision * 100:.2f}%")
print(f"Recall   : {recall * 100:.2f}%")
print(f"F1 Score : {f1 * 100:.2f}%")

print()
print("Confusion Matrix:")
print()
print("                 Predicted")
print("              Healthy  Varroa")
print(
    f"Actual Healthy   {true_negative:4d}     {false_positive:4d}"
)
print(
    f"Actual Varroa    {false_negative:4d}     {true_positive:4d}"
)

print()
print("Testing complete.")