from mlem.api import init
from mlem.core.metadata import save
from model import CustomModel


def main():
    init()
    save(CustomModel(), "custom_model")


if __name__ == '__main__':
    main()