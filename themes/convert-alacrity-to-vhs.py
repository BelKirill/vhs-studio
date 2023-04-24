#!/usr/bin/env python3
#
# Convert alacritty theme format to json format for VHS

import argparse
import yaml
import json


def main():
    args = parse_arg()

    alacritty_theme = parse_alacritty_theme(args.file)
    vhs_theme = convert_alacritty_to_vhs(alacritty_theme)

    print(json.dumps(vhs_theme))


def parse_arg():
    parser = argparse.ArgumentParser(description="Parse an Alacritty theme into a VHS custom theme")
    parser.add_argument("-f", "--file", type=str, required=True, help="Path to an Alacritty theme")
    return parser.parse_args()


def parse_alacritty_theme(file_path):
    with open(file_path, "r") as f:
        yaml_dict = yaml.safe_load(f)
    return yaml_dict


def change_to_hex(alacritty: dict) -> dict:
    hex_colors = {
        "colors": {
            "primary": {},
            "normal": {},
            "bright": {},
        }
    }

    for section_name, section in alacritty["colors"].items():
        for color_name, color in section.items():
            hex_colors["colors"][section_name][color_name] = color.replace("0x", "#")

    return hex_colors


def init_vhs_theme(alacritty: dict) -> dict:
    vhs_theme = {
        "name": "Alacritty",
        "background": alacritty["colors"]["primary"]["background"],
        "foreground": alacritty["colors"]["primary"]["foreground"],
        "selection": alacritty["colors"]["bright"]["black"],
        "cursor": alacritty["colors"]["primary"]["foreground"],
    }

    return vhs_theme


def extract_normals(alacritty: dict) -> dict:
    normal_colors = {}
    for color_name, color in alacritty["colors"]["normal"].items():
        normal_colors[color_name] = color

    return normal_colors


def extract_brights(alacritty: dict) -> dict:
    bright_colors = {}
    for color_name, color in alacritty["colors"]["bright"].items():
        bright_colors[f"bright{color_name.capitalize()}"] = color

    return bright_colors


def convert_alacritty_to_vhs(alacritty: dict) -> dict:
    alacritty = change_to_hex(alacritty)
    vhs_theme = init_vhs_theme(alacritty)
    vhs_theme.update(extract_normals(alacritty))
    vhs_theme.update(extract_brights(alacritty))

    return vhs_theme


if __name__ == "__main__":
    main()

