set -exu
mlem init
mlem config set core.index.type file
mlem clone ../simple/data/model ./data/model
mlem clone ../simple/data/test_x ./data/test_x
mlem link data/model latest
mlem apply latest data/test_x -m predict_proba -o data/pred
mlem ls
