from mlem.core.objects import MlemLink


def main():
    link = MlemLink(
        path="first",
        link_type="model"
    )
    link.dump("the_link")


if __name__ == '__main__':
    main()