# Arduino UNO

Part list:

* AptoFun Dot Matrix MAX7219 (4 in 1 Dot Matrix Green Anzeige) 
    https://www.amazon.de/AptoFun-Matrix-MAX7219-Display-Arduino/dp/B0827ZC68Y?th=1

* SCD30  CO2 SENSOR I2C/MODBUS/PWM DIGITL 
    https://www.digikey.de/product-detail/de/sensirion-ag/SCD30/1649-1098-ND/8445334

* (Arduino Clone) Maker Uno: https://www.cytron.io/p-maker-uno-simplifying-arduino-for-education


### SCD Co2 Sensor

SCD30  |  Arduino-UNO
-------|-------------
VNN    |  3.3V
GND    |  GND
SCL    |  SCL
SDA    |  SDA

http://librarymanager/All#SparkFun_SCD30
https://www.arduino.cc/reference/en/libraries/sparkfun-scd30-arduino-library/

------------------------------------------------

## AptoFun Dot Matrix MAX7219 (4 in 1 Dot Matrix Green Anzeige) 

https://luma-led-matrix.readthedocs.io/en/latest/python-usage.html

ok: https://www.makerguides.com/max7219-led-dot-matrix-display-arduino-tutorial/


MAX7219     | Arduino
------------|-------------
VCC	    RED | 5 V
GND	    BRN | GND
DIN	    ORA | 11 (MOSI)
CS	    GRN | 3 (SS)
CLK	    YEL | 13 (SCK)

Next: Replace Arduino Uno with Arduino Pro Mini

=============================================================================================

RASPBERRY PI VERSION
--------------------

Rpi-Library for SCD30:
https://github.com/UnravelTEC/Raspi-Driver-SCD30

Rpi-Library for MAX7219-Display:
https://luma-led-matrix.readthedocs.io/en/latest/intro.html

MAX7219  |            | RPi Pin RPi Function
---------|------------|----------------------
VCC +5V  | Power      |  2 5V0
GND      | Ground     |  6 GND
DIN      | Data In    | 19 GPIO 10 (MOSI)
CS       | Chip Select| 24 GPIO 8 (SPI CE0)
CLK      | Clock      | 23 GPIO 11 (SPI CLK)


SCD30      | RPi Pin 3B
-----------|-----------------------------------
RX/SDA     | I2C1 SDA (GPIO2)
TX/SCL     | I2C1 SCL (GPIO3)
VIN        | 3.3V/5.5V (use one of PWR pinouts)
GND        | GND (use one of GND pinouts)

Pinout-Image:
https://peppe8o.com/raspberry-pi-zero-pinout/

On RASPBERRY-Pin

## As root
```bash
 passwd
 apt update
 apt upgrade
 apt install vim git python-crcmod  pigpio python-pigpio build-essential python3-dev python3-pip libfreetype6-dev libjpeg-dev libopenjp2-7 libtiff5

 sed -i "s|^ExecStart=.*|ExecStart=/usr/bin/pigpiod -l -n 127.0.0.1|" /lib/systemd/system/pigpiod.service
 systemctl restart pigpiod
 comment: Test (should return an int)
 pigs hwver

 curl -LJO  https://raw.githubusercontent.com/raspihats/raspihats/master/clk_stretch/i2c1_get_clkt_tout.c
 curl -LJO  https://raw.githubusercontent.com/raspihats/raspihats/master/clk_stretch/i2c1_set_clkt_tout.c

 gcc -o i2c1_set_clkt_tout i2c1_set_clkt_tout.c
 gcc -o i2c1_get_clkt_tout i2c1_get_clkt_tout.c

comment execute (add to /etc/rc.local to run on every boot):

 ./i2c1_set_clkt_tout 20000 # for 200ms
 cp ./i2c1_get_clkt_tout /usr/local/bin

 usermod -a -G spi,gpio pi
 pip3 install --upgrade --ignore-installed pip setuptools
 pip3 install --upgrade luma.led_matrix
```
raspi-config navigate to P5 I2C and select <Yes>.

    Run sudo raspi-config
    Use the down arrow to select 5 Interfacing Options
    Arrow down to P4 SPI
    Select yes when it asks you to enable SPI
    Also select yes when it asks about automatically loading the kernel module
    Use the right arrow to select the <Finish> button
    Reboot.

As pi:

git clone https://github.com/rm-hull/luma.led_matrix.git
git clone https://github.com/UnravelTEC/Raspi-Driver-SCD30

As root:

in Raspi-Driver-SCD30:
 bash install.sh

From now on, the scd data are written to /var/run/sensors/scd30/last
