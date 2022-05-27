# Simple JSON parser for metadata files generated by yt-dlp to extract the important parts

import json
import sys
import pyperclip

json = json.loads(open(sys.argv[1], 'r').read())

value1 = json['title']
pyperclip.copy(f"{value1}")
input(f"Title copied to clipboard!\nPress Enter to continue...")

if "description" in json:
    value2 = json['description']
    if value2 == "":
        print("Description empty, skipping!")
    else:
        pyperclip.copy(f"{value2}")
        input(f"Description copied to clipboard!\nPress Enter to continue...")
else:
    print("No description found!\nPress Enter to continue...")

if "tags" in json:
    value3 = json['tags']
    if value3 == "":
        print("Tags empty, skipping!")
    else:
        join = ','.join(value3)
        pyperclip.copy(join)
        print(f"Tags copied to clipboard!")
else:
    print("No tags found!\nPress Enter to exit...")
