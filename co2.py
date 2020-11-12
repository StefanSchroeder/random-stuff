#!/usr/bin/env python3

import time

from luma.led_matrix.device import max7219
from luma.core.interface.serial import spi, noop
from luma.core.legacy import text, canvas
from luma.core.legacy.font import proportional, CP437_FONT

SLEEPTIME=20 # seconds

# Hardware specific
COUNT=4
ORIENTATION=90
ROTATE=2
REVERSE_ORDER=True

# Where we get our data
SENSOR_FILE="/var/run/sensors/scd30/last"

def output():
    serial = spi(port=0, device=0, gpio=noop())
    device = max7219(serial,
            cascaded=COUNT,
            block_orientation=ORIENTATION,
            rotate=ROTATE,
            blocks_arranged_in_reverse_order=REVERSE_ORDER)

    while True:
        fp = open(SENSOR_FILE, "r")
        line = fp.readline()
        fp.close()
        print(line)
        value = line.split() # Split at space
        msg = value[1].split(".")[0]
        with canvas(device) as draw:
            text(draw, (0,0), msg, fill="white", font=proportional(CP437_FONT))
        time.sleep(SLEEPTIME)

try:
    output()
except KeyboardInterrupt:
    pass
