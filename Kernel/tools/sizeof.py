
import sys 
import os

print(sys.argv[1] + ": " + str(round(os.path.getsize(sys.argv[1]) / 1024,2)) + " KB")