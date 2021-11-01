import sys

import pandas as pd
import yaml
from sklearn.ensemble import RandomForestClassifier

from mlem.api import load, save


def main():
    params = yaml.safe_load(open("params.yaml"))["train"]

    if len(sys.argv) != 3:
        sys.stderr.write("Arguments error. Usage:\n")
        sys.stderr.write("\tpython train.py features model\n")
        sys.exit(1)

    input = sys.argv[1]
    output = sys.argv[2]
    seed = params["seed"]
    n_est = params["n_est"]
    min_split = params["min_split"]

    df: pd.DataFrame = load(input)
    x = df.drop("target", axis=1)
    labels = df.target

    sys.stderr.write("Input matrix size {}\n".format(df.shape))
    sys.stderr.write("X matrix size {}\n".format(x.shape))
    sys.stderr.write("Y matrix size {}\n".format(labels.shape))

    clf = RandomForestClassifier(
        n_estimators=n_est,
        min_samples_split=min_split,
        n_jobs=2,
        random_state=seed,
    )

    clf.fit(x, labels)

    save(clf, output, tmp_sample_data=x)


if __name__ == "__main__":
    main()
