from mlem.core.objects import LinkData, MlemLink


def main():
    link = MlemLink(
        link_data=LinkData(path="second"),
        link_type="model"
    )
    link.dump("the_link")


if __name__ == '__main__':
    main()