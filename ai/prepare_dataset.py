import json
import shutil
from pathlib import Path
import random

# =========================
# PATHS
# =========================

DATASET_ROOT = Path(r"C:\Users\Tripti\Downloads\BeeDataset_20201121")
OUTPUT_ROOT = Path(__file__).resolve().parent / "dataset"

SEED = 42
random.seed(SEED)

TRAIN_RATIO = 0.70
VAL_RATIO = 0.15

# We will use ONE image folder/resolution only.
# This prevents the same labeled bee from appearing multiple times.
IMAGE_FOLDER = "images_300"

IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png"}


# =========================
# CHECK DATASET
# =========================

json_path = DATASET_ROOT / "data.json"
image_root = DATASET_ROOT / IMAGE_FOLDER

if not json_path.exists():
    raise FileNotFoundError(f"data.json not found: {json_path}")

if not image_root.exists():
    raise FileNotFoundError(f"{IMAGE_FOLDER} folder not found: {image_root}")


# =========================
# LOAD LABELS
# =========================

with open(json_path, "r", encoding="utf-8") as f:
    labels = json.load(f)

print(f"Loaded {len(labels)} labeled images.")
print(f"Using image folder: {IMAGE_FOLDER}")


# =========================
# FIND IMAGES
# =========================

image_lookup = {}

for path in image_root.rglob("*"):
    if path.is_file() and path.suffix.lower() in IMAGE_EXTENSIONS:
        image_lookup[path.name] = path

print(f"Found {len(image_lookup)} images in {IMAGE_FOLDER}.")


# =========================
# CLASSIFY
# =========================

varroa_images = []
healthy_images = []

ignored_images = []
missing_images = []


for filename, info in labels.items():

    image_path = image_lookup.get(filename)

    if image_path is None:
        missing_images.append(filename)
        continue

    varroa = info.get("varroa", False)
    pollen = info.get("pollen", False)
    cooling = info.get("cooling", False)
    wasps = info.get("wasps", False)

    # VARROA
    if varroa is True:
        varroa_images.append(image_path)

    # HEALTHY:
    # No Varroa, pollen, cooling or wasp label
    elif (
        varroa is False
        and pollen is False
        and cooling is False
        and wasps is False
    ):
        healthy_images.append(image_path)

    # Other conditions are ignored
    else:
        ignored_images.append(filename)


print()
print("Classification results:")
print(f"  Varroa:  {len(varroa_images)}")
print(f"  Healthy: {len(healthy_images)}")
print(f"  Ignored: {len(ignored_images)}")
print(f"  Missing: {len(missing_images)}")


# =========================
# SPLIT FUNCTION
# =========================

def split_images(images):

    images = images.copy()
    random.shuffle(images)

    total = len(images)

    train_end = int(total * TRAIN_RATIO)
    val_end = train_end + int(total * VAL_RATIO)

    train = images[:train_end]
    validation = images[train_end:val_end]
    test = images[val_end:]

    return train, validation, test


healthy_train, healthy_val, healthy_test = split_images(healthy_images)
varroa_train, varroa_val, varroa_test = split_images(varroa_images)


# =========================
# CREATE OUTPUT DIRECTORIES
# =========================

for split in ["train", "validation", "test"]:
    for category in ["healthy", "varroa"]:

        folder = OUTPUT_ROOT / split / category
        folder.mkdir(parents=True, exist_ok=True)


# =========================
# COPY IMAGES
# =========================

def copy_images(images, destination):

    for image_path in images:
        destination_path = destination / image_path.name
        shutil.copy2(image_path, destination_path)


copy_images(
    healthy_train,
    OUTPUT_ROOT / "train" / "healthy"
)

copy_images(
    healthy_val,
    OUTPUT_ROOT / "validation" / "healthy"
)

copy_images(
    healthy_test,
    OUTPUT_ROOT / "test" / "healthy"
)

copy_images(
    varroa_train,
    OUTPUT_ROOT / "train" / "varroa"
)

copy_images(
    varroa_val,
    OUTPUT_ROOT / "validation" / "varroa"
)

copy_images(
    varroa_test,
    OUTPUT_ROOT / "test" / "varroa"
)


# =========================
# FINAL SUMMARY
# =========================

print()
print("====================================")
print("DATASET PREPARATION COMPLETE")
print("====================================")

print()
print("Training:")
print(f"  Healthy: {len(healthy_train)}")
print(f"  Varroa:  {len(varroa_train)}")

print()
print("Validation:")
print(f"  Healthy: {len(healthy_val)}")
print(f"  Varroa:  {len(varroa_val)}")

print()
print("Testing:")
print(f"  Healthy: {len(healthy_test)}")
print(f"  Varroa:  {len(varroa_test)}")

print()
print("Prepared dataset:")
print(OUTPUT_ROOT)