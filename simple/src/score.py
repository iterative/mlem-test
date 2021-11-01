import json
import sys

import sklearn.metrics as metrics

from mlem.api import load


def main():
    if len(sys.argv) != 4:
        sys.stderr.write("Arguments error. Usage:\n")
        sys.stderr.write(
            "\tpython evaluate.py model features scores prc roc\n"
        )
        sys.exit(1)

    pred_file = sys.argv[1]
    true_file = sys.argv[2]
    scores_file = sys.argv[3]

    predictions = load(pred_file)

    labels = load(true_file)

    roc_auc = metrics.roc_auc_score(labels, predictions, multi_class="ovr")

    with open(scores_file, "w") as fd:
        json.dump({"roc_auc": roc_auc}, fd, indent=4)


if __name__ == "__main__":
    main()
