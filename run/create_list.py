import glob
import os
import json
import sys

if len(sys.argv) == 2:
    dir = sys.argv[1]
else:
    dir = '.' + os.sep
print(dir)

files_list = glob.glob(dir + '*.png') + glob.glob(dir + '*.jpg')
print(files_list)

labels = []
objects = {}

for file in files_list:
    label = file.split(os.sep)[-1].split('.')[0]
    path = os.path.abspath(file)
    print(label, path)

    if label in labels:
        raise Exception('An item with the label {} already exists in the gallery!'.format(label))
    else:
        labels.append(label)
        objects[label] = [path]

with open('faces_gallery.json', 'w') as outfile:
    json.dump(objects, outfile)


