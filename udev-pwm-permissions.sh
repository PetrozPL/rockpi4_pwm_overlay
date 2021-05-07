#!/bin/bash
############################################################################
# Copyright (c) 2021 Piotr Wroblewski.
# 
# This program is free software: you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation, version 2.
# 
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License 
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# udev-pwm-permissions.sh
# this script set permissions for PWM to digital group. To use PWM without sudo 
# user should be added to digital group
# this script also initialize both PWM outputs
# this script should be called once at system startup with sudo privilges
#
############################################################################

# Result: chown <USERNAME>:digital /sys/class/gpio

#set permissions
chown -R :digital /sys/class/pwm/pwmchip1/
chown -R :digital /sys/class/pwm/pwmchip2/

find /sys/class/pwm/pwmchip1/ -name export -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name unexport -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip2/ -name export -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip2/ -name unexport -exec chmod g+rw {} \;

#initialize both pwmchip
echo 0 > /sys/class/pwm/pwmchip1/export
echo 0 > /sys/class/pwm/pwmchip2/export

chown -R :digital /sys/class/pwm/pwmchip1/
chown -R :digital /sys/class/pwm/pwmchip2/

#set permissions for PWM parameters ( duty_cycle enable period polarity power uevent )
find /sys/class/pwm/pwmchip1/ -name "duty_cycle" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "enable" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "period" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "polarity" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "power" -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name "uevent" -exec chmod 0660 {} \;

find /sys/class/pwm/pwmchip1/ -name export -exec chmod g+rw {} \;
find /sys/class/pwm/pwmchip1/ -name unexport -exec chmod g+rw {} \; 

# if initialization of particular FAN is required, it can be called here 
# i.e. set FAN speed to 100%
/usr/local/bin/pwmset 100 -v
#wait for 10 sec
sleep 10
#decrese speed to 35%
/usr/local/bin/pwmset 35 -v
