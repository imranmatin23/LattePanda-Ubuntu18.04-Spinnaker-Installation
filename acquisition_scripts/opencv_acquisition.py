import sys
sys.path.append('../EasyPySpin/')
import cv2
import EasyPySpin
import time

cap = EasyPySpin.VideoCapture(0)

cap.set(cv2.CAP_PROP_EXPOSURE, 10000)
cap.set(cv2.CAP_PROP_GAIN, 10)
cap.set(cv2.CAP_PROP_FPS, 8)

ret, frame = cap.read()

start_time = time.time()

for fr in range(10):
    ret, frame = cap.read()
    name = "frame" + str(fr) + ".png"
    # cv2.imwrite(name, frame)
    t = time.time() - start_time
    print("Frame " + str(fr) + ": " + str(t) + " sec")

cap.release()
