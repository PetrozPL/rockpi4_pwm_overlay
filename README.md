# rockpi4_pwm_overlay
rockpi 4 pwm overlay code

to create pwm overlay call : 

  dtc -O dtb -o rockchip-pwm-gpio.dtbo -b 0 -@ rockchip-pwm-gpio.dts

and move dtbo to /boot/dtc/rockchip/overlays

to activate overlay, modify /boot/armbianEnv.txt by adding: 

  overlay_prefix=rockchip
  overlays=pwm-gpio
  
to control FAN SPEED via PWM use pwmset and pwmsts scripts

example : 
  pwmset 45 - set PWM speed to 45%
  
  pwmsts 
  45
