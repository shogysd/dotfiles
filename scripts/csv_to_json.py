#!/usr/bin/env python3

import csv
import io
import json
import select
import sys


def main():
    if 2 < len(sys.argv):
        print(
            "error: arg error: " +
            str(sys.argv[1:]) +
            "\nplease specify the file name as an argument or use stdin ( e.g. `cat | ` )", file=sys.stderr
        )
        sys.exit(999)

    elif 2 == len(sys.argv):
        try:
            with open(sys.argv[1], "r") as f:
                print(
                    json.dumps(
                        [
                            i for i in csv.DictReader(f)
                        ],
                        sort_keys=True,
                        indent=4,
                        ensure_ascii=False
                    )
                )
        except FileNotFoundError:
            print(
                "error: " +
                str(sys.argv[1]) +
                ": No such file", file=sys.stderr
            )
            sys.exit(999)

    else:
        if not select.select([sys.stdin], [], [], 0.0)[0]:
            print(
                "error: arg or stdin error: " +
                str(sys.argv[1:]) +
                "\nplease specify the file name as an argument or use stdin ( e.g. `cat | ` )", file=sys.stderr
            )
            sys.exit(999)

        else:
            print(
                json.dumps(
                    [
                        i for i in csv.DictReader(
                            io.StringIO(
                                sys.stdin.read()
                            )
                        )
                    ],
                    sort_keys=True,
                    indent=4,
                    ensure_ascii=False
                )
            )


if __name__ == "__main__":
    main()
