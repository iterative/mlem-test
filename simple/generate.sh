set -exu
mlem init
python src/generate_data.py
python src/train.py data/train data/model
mlem link data/model latest
mlem apply latest data/test_x -m predict_proba -o data/pred
python src/score.py data/pred data/test_y scores.json
