set -exu
mlem init
python src/generate_data.py
python src/train.py train model
mlem link model latest
mlem apply latest test_x -m predict_proba -o pred
python src/score.py pred test_y scores.json
