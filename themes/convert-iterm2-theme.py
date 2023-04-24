#!/usr/bin/env python3
#
# Convert .itermcolors files to hex colors for html

import sys
import xml.etree.ElementTree as ET

def rgb_to_hex(rgb):
  return '#%02x%02x%02x' % rgb

# MAIN
def main():

  RED_KEY = 9
  GREEN_KEY = 7 
  BLUE_KEY = 3

  if len(sys.argv) < 2:
    print("usage: ./convert_itermcolors.py file.itermcolors")
    exit()

  tree = ET.parse(sys.argv[1])
  root = tree.getroot()

  keys = root.findall("./dict/key")
  dicts = root.findall("./dict/dict")

  for i in range(len(keys)):
    r = int(float(dicts[i][RED_KEY].text) * 255.0)
    g = int(float(dicts[i][GREEN_KEY].text) * 255.0)
    b = int(float(dicts[i][BLUE_KEY].text) * 255.0)
    print(rgb_to_hex((r, g, b)) + " rgb({}, {}, {})".format(r, g, b) + " //" + keys[i].text)

if __name__ == '__main__':
  main()
