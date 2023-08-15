# ssanchaaa's python script
import time
from sys import argv

script, data, dir_lvl = argv


data=data[2:].split("/")
data=" ".join(data[-int(dir_lvl):])


i=0
while i != len(data):
    if  data[i].isalpha() == False:
        data = data.replace(data[i], " ")
        i+=1
    else:
        i+=1


data = data.title().replace(" ", "")
print(data)
