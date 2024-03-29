#!/usr/bin/env python3

import csv
import io
import json
import select
import sys


def file_encode_flag(filename):
    file_encode = ""
    try:
        with open(filename, "r", encoding="utf-8") as f:
            if "\ufeff" == f.readline()[0]:
                file_encode = "utf-8-sig"
            else:
                file_encode = "utf-8"

    except UnicodeDecodeError:
        print("UnicodeDecodeError: 'utf-8' codec can't decode", file=sys.stderr)
        sys.exit(999)

    return file_encode


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
            with open(sys.argv[1], "r", encoding=file_encode_flag(filename=sys.argv[1])) as f:
                print(
                    json.dumps(
                        [
                            i for i in csv.DictReader(f)
                        ],
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
                    indent=4,
                    ensure_ascii=False
                )
            )


if __name__ == "__main__":
    main()
