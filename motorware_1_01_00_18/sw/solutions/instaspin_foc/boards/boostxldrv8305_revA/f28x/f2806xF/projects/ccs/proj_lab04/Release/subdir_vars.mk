################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CMD_SRCS += \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/ide/ccs/cmd/f2806x/f28069F_ram_lnk.cmd 

LIB_SRCS += \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/fast/lib/32b/f28x/f2806x/2806xRevB_FastSpinROMSymbols.lib \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/iqmath/lib/f28x/32b/IQmath.lib 

ASM_SRCS += \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/cpu/src/32b/f28x/f2806x/CodeStartBranch.asm \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/usDelay/src/32b/f28x/usDelay.asm 

C_SRCS += \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/adc/src/32b/f28x/f2806x/adc.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/clarke/src/32b/clarke.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/clk/src/32b/f28x/f2806x/clk.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/cpu/src/32b/f28x/f2806x/cpu.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/ctrl/src/32b/ctrl.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/drvic/drv8305/src/32b/f28x/f2806x/drv8305.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/filter/src/32b/filter_fo.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/flash/src/32b/f28x/f2806x/flash.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/gpio/src/32b/f28x/f2806x/gpio.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/hal/boards/boostxldrv8305_revA/f28x/f2806x/src/hal.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/ipark/src/32b/ipark.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/offset/src/32b/offset.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/osc/src/32b/f28x/f2806x/osc.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/park/src/32b/park.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/pid/src/32b/pid.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pie/src/32b/f28x/f2806x/pie.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pll/src/32b/f28x/f2806x/pll.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/solutions/instaspin_foc/src/proj_lab04.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pwm/src/32b/f28x/f2806x/pwm.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pwr/src/32b/f28x/f2806x/pwr.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/sci/src/32b/f28x/f2806x/sci.c \
../scihelper.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/spi/src/32b/f28x/f2806x/spi.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/svgen/src/32b/svgen.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/timer/src/32b/f28x/f2806x/timer.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/traj/src/32b/traj.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/user/src/32b/user.c \
/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/wdog/src/32b/f28x/f2806x/wdog.c 

C_DEPS += \
./adc.d \
./clarke.d \
./clk.d \
./cpu.d \
./ctrl.d \
./drv8305.d \
./filter_fo.d \
./flash.d \
./gpio.d \
./hal.d \
./ipark.d \
./offset.d \
./osc.d \
./park.d \
./pid.d \
./pie.d \
./pll.d \
./proj_lab04.d \
./pwm.d \
./pwr.d \
./sci.d \
./scihelper.d \
./spi.d \
./svgen.d \
./timer.d \
./traj.d \
./user.d \
./wdog.d 

OBJS += \
./CodeStartBranch.obj \
./adc.obj \
./clarke.obj \
./clk.obj \
./cpu.obj \
./ctrl.obj \
./drv8305.obj \
./filter_fo.obj \
./flash.obj \
./gpio.obj \
./hal.obj \
./ipark.obj \
./offset.obj \
./osc.obj \
./park.obj \
./pid.obj \
./pie.obj \
./pll.obj \
./proj_lab04.obj \
./pwm.obj \
./pwr.obj \
./sci.obj \
./scihelper.obj \
./spi.obj \
./svgen.obj \
./timer.obj \
./traj.obj \
./usDelay.obj \
./user.obj \
./wdog.obj 

ASM_DEPS += \
./CodeStartBranch.d \
./usDelay.d 

OBJS__QUOTED += \
"CodeStartBranch.obj" \
"adc.obj" \
"clarke.obj" \
"clk.obj" \
"cpu.obj" \
"ctrl.obj" \
"drv8305.obj" \
"filter_fo.obj" \
"flash.obj" \
"gpio.obj" \
"hal.obj" \
"ipark.obj" \
"offset.obj" \
"osc.obj" \
"park.obj" \
"pid.obj" \
"pie.obj" \
"pll.obj" \
"proj_lab04.obj" \
"pwm.obj" \
"pwr.obj" \
"sci.obj" \
"scihelper.obj" \
"spi.obj" \
"svgen.obj" \
"timer.obj" \
"traj.obj" \
"usDelay.obj" \
"user.obj" \
"wdog.obj" 

C_DEPS__QUOTED += \
"adc.d" \
"clarke.d" \
"clk.d" \
"cpu.d" \
"ctrl.d" \
"drv8305.d" \
"filter_fo.d" \
"flash.d" \
"gpio.d" \
"hal.d" \
"ipark.d" \
"offset.d" \
"osc.d" \
"park.d" \
"pid.d" \
"pie.d" \
"pll.d" \
"proj_lab04.d" \
"pwm.d" \
"pwr.d" \
"sci.d" \
"scihelper.d" \
"spi.d" \
"svgen.d" \
"timer.d" \
"traj.d" \
"user.d" \
"wdog.d" 

ASM_DEPS__QUOTED += \
"CodeStartBranch.d" \
"usDelay.d" 

ASM_SRCS__QUOTED += \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/cpu/src/32b/f28x/f2806x/CodeStartBranch.asm" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/usDelay/src/32b/f28x/usDelay.asm" 

C_SRCS__QUOTED += \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/adc/src/32b/f28x/f2806x/adc.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/clarke/src/32b/clarke.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/clk/src/32b/f28x/f2806x/clk.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/cpu/src/32b/f28x/f2806x/cpu.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/ctrl/src/32b/ctrl.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/drvic/drv8305/src/32b/f28x/f2806x/drv8305.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/filter/src/32b/filter_fo.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/flash/src/32b/f28x/f2806x/flash.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/gpio/src/32b/f28x/f2806x/gpio.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/hal/boards/boostxldrv8305_revA/f28x/f2806x/src/hal.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/ipark/src/32b/ipark.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/offset/src/32b/offset.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/osc/src/32b/f28x/f2806x/osc.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/park/src/32b/park.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/pid/src/32b/pid.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pie/src/32b/f28x/f2806x/pie.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pll/src/32b/f28x/f2806x/pll.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/solutions/instaspin_foc/src/proj_lab04.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pwm/src/32b/f28x/f2806x/pwm.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/pwr/src/32b/f28x/f2806x/pwr.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/sci/src/32b/f28x/f2806x/sci.c" \
"../scihelper.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/spi/src/32b/f28x/f2806x/spi.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/svgen/src/32b/svgen.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/timer/src/32b/f28x/f2806x/timer.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/traj/src/32b/traj.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/modules/user/src/32b/user.c" \
"/home/rmal/ti/motorware/motorware_1_01_00_18/sw/drivers/wdog/src/32b/f28x/f2806x/wdog.c" 


