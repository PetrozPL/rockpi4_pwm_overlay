#!/bin/bash

# Result: chown <USERNAME>:digital /sys/class/gpio

chown -R :digital /sys/class/pwm/pwmchip1/
chown -R :digital /sys/class/pwm/pwmchip2/

find /sys/class/pwm/pwmchip1/ -name export -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name unexport -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip2/ -name export -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip2/ -name unexport -exec chmod g+rw {} \;

echo 0 > /sys/class/pwm/pwmchip1/export
echo 0 > /sys/class/pwm/pwmchip2/export

chown -R :digital /sys/class/pwm/pwmchip1/
chown -R :digital /sys/class/pwm/pwmchip2/

#PWM ( duty_cycle enable period polarity power uevent )
find /sys/class/pwm/pwmchip1/ -name "duty_cycle" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "enable" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "period" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "polarity" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "power" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "uevent" -exec chmod 0660 {} \;

find /sys/class/pwm/pwmchip1/ -name export -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name unexport -exec chmod g+rw {} \;

/usr/local/bin/pwmset 100 -v

sleep 10

/usr/local/bin/pwmset 35 -v
