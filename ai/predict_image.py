import sys
from pathlib import Path
import json

import numpy as np
import tensorflow as tf


MODEL_PATH = Path(__file__).parent / "bee_disease_model.keras"
IMAGE_SIZE = (224, 224)


def predict_image(image_path):
    # Load trained model
    model = tf.keras.models.load_model(MODEL_PATH)

    # Load and resize image
    image = tf.keras.utils.load_img(
        image_path,
        target_size=IMAGE_SIZE
    )

    # Convert image to array
    image_array = tf.keras.utils.img_to_array(image)

    # Add batch dimension
    image_array = np.expand_dims(image_array, axis=0)

    # Model prediction
    probability = model.predict(
        image_array,
        verbose=0
    )[0][0]

    # Classification
    if probability >= 0.70:
        prediction = "Possible Varroa"
        confidence = probability

    elif probability <= 0.30:
        prediction = "Healthy"
        confidence = 1 - probability

    else:
        prediction = "Needs Inspection"
        confidence = 0.50

    # Return JSON for Node.js
    print(json.dumps({
        "varroaProbability": float(probability),
        "prediction": prediction,
        "confidence": float(confidence * 100)
    }))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python predict_image.py <image_path>")
        sys.exit(1)

    image_path = Path(sys.argv[1])

    if not image_path.exists():
        print(f"Error: Image not found: {image_path}")
        sys.exit(1)

    predict_image(image_path)