# rockpi4_pwm_overlay
rockpi 4 pwm overlay code

to create pwm overlay call : 

    dtc -O dtb -o rockchip-pwm-gpio.dtbo -b 0 -@ rockchip-pwm-gpio.dts

and move dtbo to /boot/dtc/rockchip/overlays

to activate overlay, modify /boot/armbianEnv.txt by adding: 

    overlay_prefix=rockchip
    overlays=pwm-gpio
  
before PWM can be used, it should be initialized by calling 

    sudo echo 0 > /sys/class/pwm/pwmchip1/export

to use it from regular user account without sudo priviliges, some steps must be taken during or after system startup : 

    1. set ownership of the pwmchip1 and pwmchip2 and all it's descriptors to digital group
    chown -R :digital /sys/class/pwm/pwmchip1/
    chown -R :digital /sys/class/pwm/pwmchip2/
    
    2. add rw priviliges to export/unexport descriptors
    find /sys/class/pwm/pwmchip1/ -name export -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip1/ -name unexport -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip2/ -name export -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip2/ -name unexport -exec chmod g+rw {} \;
    
    3. initialize PWM with export
    echo 0 > /sys/class/pwm/pwmchip2/export
    echo 0 > /sys/class/pwm/pwmchip2/export
    
    4. set ownership of all new parameters to digital groups 
    chown -R :digital /sys/class/pwm/pwmchip1/
    chown -R :digital /sys/class/pwm/pwmchip2/
    
    5. add rw priviliges to PWM parameters ( duty_cycle enable period polarity power uevent )
    find /sys/class/pwm/pwmchip1/ -name "duty_cycle" -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip1/ -name "enable" -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip1/ -name "period" -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip1/ -name "polarity" -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip1/ -name "power" -exec chmod g+rw {} \;
    find /sys/class/pwm/pwmchip1/ -name "uevent" -exec chmod 0660 {} \;

to control PWM without sudo, particular user should be added to digital group:

    sudo usermod -a -G digital <USERNAME>

after this, to control FAN SPEED via PWM use pwmset and pwmsts scripts

example :

    pwmset 45 - set PWM speed to 45%
  
    pwmsts 
    45
