#!/usr/bin/env python

import argparse
import os
from sys import argv
from typing import  Callable, Iterable, List


def main():
    args = get_parsed_args()
    find_files_with_string(
        init_dir_path=args.directory,
        string_to_find=args.text,
        ignored_files=args.ignore
    )


def find_files_with_string(init_dir_path: str, string_to_find: str, ignored_files: List[str]) -> None:
    def helper(dir_abs_path: str) -> None:
        dir_contents = os.listdir(dir_abs_path)
        for entry_name in dir_contents:
            entry_abs_path = os.path.join(dir_abs_path, entry_name)
            if _any(ignored_files, lambda ignored: ignored in entry_name):
                continue
            elif os.path.isdir(entry_abs_path):
                helper(entry_abs_path)
            elif os.path.isfile(entry_abs_path):
                with open(entry_abs_path, 'r', encoding = 'utf-8') as file:
                    file_content = file.read()
                    if string_to_find in file_content:
                        print(format_str(entry_abs_path, init_dir_path))
            else:
                raise Exception(f"File \"{entry_abs_path}\" not found")
    helper(init_dir_path)        


def format_str(string: str, init_dir_path: str) -> str: 
    return string.removeprefix(init_dir_path)[1:]


def _any(iterable: Iterable, predicate: Callable) -> bool:
    return any([predicate(element) for element in iterable])


def get_parsed_args():
    parser = argparse.ArgumentParser(prefix_chars='-')
    parser.add_argument("text", type=str, help="text to find")
    parser.add_argument("directory", nargs='?', default=os.getcwd(), help="directory in which the text will be looked for")
    parser.add_argument("-i", "--ignore", type=str, nargs='*', default=[], help="ignored files")
    return parser.parse_args()


if __name__=="__main__":
    main()
