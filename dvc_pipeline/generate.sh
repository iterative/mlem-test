set -exu
dvc init --subdir
dvc remote add -d s3store s3://mlem-test-dvc-pipeline
mlem init

mlem config set core.storage.type dvc
mlem config set core.external True

dvc run -n generate_data \
  -d src/generate_data.py \
  -o data/train -O data/train.mlem \
  -o data/test_x -O data/test_x.mlem \
  -o data/test_y -O data/test_y.mlem \
  python src/generate_data.py

dvc run -n train \
  -d src/train.py -d data/train \
  -o data/model -O data/model.mlem \
  -p train.min_split,train.n_est,train.seed \
  python src/train.py data/train data/model

mlem link data/model latest

dvc run -n predict \
    -d data/model -d data/test_x \
    -o data/pred -O data/pred.mlem \
    mlem apply latest data/test_x -m predict_proba -o data/pred

dvc run -n score \
    -d data/pred -d data/test_y -d src/score.py \
    -O scores.json \
    python src/score.py data/pred data/test_y scores.json

dvc push