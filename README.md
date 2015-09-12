# motemp
Motion and temperature sensor for the ULabs makerspace in Lubbock, TX.  Created by the Saturday electronics group, this project is meant to be easy to get started with an expand upon.  The basic device feeds readings and motion events to http://data.sparkfun.com.

Areas of expansion and collaboration:
* firmware improvements
* protoboard layout (it's all on a breadboard now)
* PCB layout
* 3D printed case designs
* Browser and mobile user interfaces


# Hardware
If you are building three or more of these the part cost should be around $20 each.  The primary components are:

* ESP8266 wifi/mcu (-01 module)
* DHT22 ambient temperature and humidity sensor (DHT22)
* PIR motion sensor (HC-SR501)
* LM317 voltage regulator configured for 3.3v output, should work on most standard 5-12v DC supplies
* enclosures

![prototype](https://github.com/ULabsTX/motemp/raw/master/prototype.jpg)


# Software
The ESP8266 runs [NodeMCU firmware](https://github.com/nodemcu/nodemcu-firmware) and uses the [DHT22 library](https://github.com/nodemcu/nodemcu-firmware/wiki/nodemcu_api_en#dhtread) and [Phant module](https://github.com/nodemcu/nodemcu-firmware/tree/master/lua_modules/phant) for transmission to data.sparkfun.com.  To flash files to the ESP8266 you will need a utility like [nodemcu-uploader](https://github.com/kmpm/nodemcu-uploader).

To flash the nodemcu firmware with [esptool](https://github.com/themadinventor/esptool):

    esptool.py --port /dev/tty.usbserial-A800F331 write_flash 0x0000 nodemcu_float_0.9.6-dev_20150704.bin

To upload the motemp program from this repository:

    nodemcu-uploader.py --port /dev/tty.usbserial-A800F331 upload motemp.lua
(insert note about toggling pins to get it to program - forgot how to do this)

To see what is going on, connect via your FTDI:

    screen /dev/tty.usbserial-A800F331 9600

To run the firmware, set up your wifi network:

    wifi.setmode(wifi.STATION)
    wifi.sta.config("SSID", "password")
    print(wifi.sta.getip())

Load the motemp program:

    dofile("motemp.lua")
    start() -- start collection
    stop() -- stop collection

You can configure your data.sparkfun.com feed information and the temperature reporting interval at the top of motemp.lua.  motemp.lua sends fields "humidity", "temperature", and "motion".


