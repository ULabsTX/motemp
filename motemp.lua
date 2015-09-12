--[[

]]--


-- configure

DHT_PIN = 4
PIR_PIN = 3
READ_INTERVAL = 15
READ_TIMER = 1

HOST = "data.sparkfun.com"
PUBLIC_KEY = ""
PRIVATE_KEY = ""

phant.init(HOST, PUBLIC_KEY, PRIVATE_KEY)

function read()
    local status,temp,humi,temp_decimial,humi_decimial = dht.read(DHT_PIN)
    
    phant.add("humidity", humi)
    phant.add("temperature", temp)

    phant.post()
end

function on_motion(level)
    print("on_motion: "..level)
end


function start()
    print("starting motemp..")
    tmr.alarm(READ_TIMER, READ_INTERVAL*1000, 1, read)
    gpio.mode(PIR_PIN, gpio.INT)
    gpio.trig(PIR_PIN, "down", on_motion)
end


function stop()
    tmr.stop(READ_TIMER)
    gpio.mode(PIR_PIN, gpio.FLOAT)
    print("stopped motemp")
end

