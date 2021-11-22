set -exu
dvc init --subdir
dvc remote add -d s3store s3://mlem-test-dvc-pipeline
mlem init

mlem config set -c DEFAULT_STORAGE.type=dvc -c DEFAULT_EXTERNAL=True

dvc run -n generate_data \
  -d src/generate_data.py \
  -o data/train/artifacts -O data/train/mlem.yaml \
  -o data/test_x/artifacts -O data/test_x/mlem.yaml \
  -o data/test_y/artifacts -O data/test_y/mlem.yaml \
  python src/generate_data.py

dvc run -n train \
  -d src/train.py -d data/train \
  -o data/model/artifacts -O data/model/mlem.yaml \
  -p train.min_split,train.n_est,train.seed \
  python src/train.py data/train data/model

mlem link data/model latest

dvc run -n predict \
    -d data/model -d data/test_x \
    -o data/pred/artifacts -O data/pred/mlem.yaml \
    mlem apply latest data/test_x -m predict_proba -o data/pred

dvc run -n score \
    -d data/pred -d data/test_y -d src/score.py \
    -O scores.json \
    python src/score.py data/pred data/test_y scores.json

dvc push