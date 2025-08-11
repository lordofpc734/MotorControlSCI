# BLDC Motor Control (MotorWare v18) — README

This repository contains code to run and control BLDC motors using Texas Instruments **MotorWare v18** via Serial (SCI/UART).

---

# Overview

This project integrates an InstaSPIN-FOC single motor example with additional SCI (UART) support so the motor controller can communicate over serial. The instructions below walk through the tested setup, importing the project into CCS, and the minimal code changes required to enable SCI A/B, interrupts, and the necessary HAL (hardware abstraction layer) changes.

---

# Tested environment & prerequisites

- **Tested on:** Ubuntu 20.04 LTS (other Linux distributions may work).
- **CCS version used:** CCS 20.2 (older CCS versions such as CCS 12 are also mentioned in the original notes and may work).
- **MotorWare:** MotorWare v18 (`motorware_1_01_00_18`) — download from TI: [https://www.ti.com/tool/MOTORWARE](https://www.ti.com/tool/MOTORWARE) *You will need a Windows machine or WINE to run the MotorWare installer/extractor to obtain the **`motorware_1_01_00_18`** directory.*
- Basic familiarity with CCS project import and editing C files in the MotorWare example tree.

---

# Quick start (high level)

1. Create a directory where you'll keep the project, e.g. `bldcMotorControl`.
2. Clone this repo into that directory.
3. Install MotorWare v18 (extract the `motorware_1_01_00_18` directory) and copy it under `.../<YOUR DIR>/` so that `<YOUR DIR>` contains both the `bldcMotorControlProject` and `motorware_1_01_00_18`.
4. Start CCS → **Import Project(s)** → navigate to the provided InstaSPIN project path inside the repo and import.
5. Make the HAL and project changes described below (adding SCI sources, handles, initialization, GPIO, interrupts, etc).
6. Build and test.

---

# Detailed steps

## 1) Project import

Import the project found at:

```
.../<YOUR DIR>/bldcMotorControlProject/sw/solutions/instaspin_foc/boards/boostxldrv8305_revA/singleMotorControlProj/
```

CCS should detect the project as `singleMotorSciA`. When the import dialog asks, **select "Import projects at their original locations"** (this creates symlinks rather than copying files into the workspace).

---

## 2) Add SCI driver files to the project

Temporarily add the SCI driver files (right-click project → *Add Files/Folders*):

```
.../<YOUR DIR>/motorware_1_01_00_18/sw/drivers/sci/src/32b/f28x/f2806x/sci.c
.../<YOUR DIR>/motorware_1_01_00_18/sw/drivers/sci/src/32b/f28x/f2806x/sci.h
```

---

## 3) Add SCI handles to HAL object (hal\_obj.h)

Modify the `_HAL_Obj_` struct in:

```
.../<YOUR DIR>/motorware_1_01_00_18/sw/modules/hal/boards/boostxldrv8305_revA/f28x/f2806x/src/hal_obj.h
```

Add the SCI handles to the end of the `_HAL_Obj_` struct:

```c
SCI_Handle  sciAHandle;            //!< the SCI handle
SCI_Handle  sciBHandle;            //!< the SCI handle
```

---

## 4) Initialize the SCI handles in `HAL_init` (hal.c)

In `hal.c` add the SCI init calls to the end of `HAL_init` (before return). Insert exactly:

```c
// initialize the SCI handles
  obj->sciAHandle = SCI_init((void *)SCIA_BASE_ADDR,sizeof(SCI_Obj));
  obj->sciBHandle = SCI_init((void *)SCIB_BASE_ADDR,sizeof(SCI_Obj));
```

---

## 5) Add SCI setup functions to `hal.c`

Add the following function implementations to `hal.c` **(copy verbatim)**:

```c
void HAL_setupSciA(HAL_Handle handle)
{
  HAL_Obj *obj = (HAL_Obj *)handle;

  SCI_reset(obj->sciAHandle);
  SCI_enableTx(obj->sciAHandle);
  SCI_enableRx(obj->sciAHandle);
  
  SCI_disableParity(obj->sciAHandle);
  SCI_setNumStopBits(obj->sciAHandle,SCI_NumStopBits_One);
  SCI_setCharLength(obj->sciAHandle,SCI_CharLength_8_Bits);
  // set baud rate to 115200
  SCI_setBaudRate(obj->sciAHandle,(SCI_BaudRate_e)(0x0061));
  SCI_setPriority(obj->sciAHandle,SCI_Priority_FreeRun);
  
  SCI_enable(obj->sciAHandle);
  return;
  // end of HAL_setupSciA() function
}
```

and

```c
void HAL_setupSciB(HAL_Handle handle)
{
  HAL_Obj *obj = (HAL_Obj *)handle;

  SCI_reset(obj->sciBHandle);
  SCI_enableTx(obj->sciBHandle);
  SCI_enableRx(obj->sciBHandle);
  
  SCI_disableParity(obj->sciBHandle);
  SCI_setNumStopBits(obj->sciBHandle,SCI_NumStopBits_One);
  SCI_setCharLength(obj->sciBHandle,SCI_CharLength_8_Bits);
  // set baud rate to 115200
  SCI_setBaudRate(obj->sciBHandle,(SCI_BaudRate_e)(0x0061));
  SCI_setPriority(obj->sciBHandle,SCI_Priority_FreeRun);
  
  SCI_enable(obj->sciBHandle);
  return;
  // end of HAL_setupSciB() function
}
```

**Note on Baud Rate:** The example sets the SCI baud rate to 115200. The baud constant used is `0x0061`. The relationship is:

```
BaudRate = LSPCLK / (f_UART * 8) - 1
 e.g. BaudRate = 90MHz / (115200 * 8) - 1 = 0x0061 (HEX)
```

Adjust the formula and value if your LSPCLK or desired baud differs.

---

## 6) Call the SCI setup functions from `HAL_setParams(...)` (hal.c)

Add these calls in `HAL_setParams(...)` so the SCI is initialized during HAL setup (insert them near other peripheral setups):

```c
  // setup the spiB
  HAL_setupSpiB(handle);

  
  // setup the sciA
  HAL_setupSciA(handle);
```

(If you need SCI B as well, add `HAL_setupSciB(handle);` accordingly.)

---

## 7) Enable the SCI clocks (hal.c)

In `hal.c`, enable the SCI clocks. The original instruction suggested commenting out or replacing any `CLK_disableSciaClock(obj->clkHandle);` and instead enable SCIA/SCIB:

```c
  CLK_enableSciaClock(obj->clkHandle);
  CLK_enableScibClock(obj->clkHandle);
```

---

## 8) GPIO pin mapping for SCI

If you are using SCIA on GPIO ports 28 (RX) and 29 (TX), update the UARTB (or UARTA) GPIO mappings in `hal.c`. Example snippet from the original instructions (copy verbatim):

```c
  // UARTB RX
  //GPIO_setMode(obj->gpioHandle,GPIO_Number_15,GPIO_15_Mode_SCIRXDB);
  GPIO_setMode(obj->gpioHandle,GPIO_Number_28,GPIO_28_Mode_SCIRXDA);
  ...
  // UARTB TX
  //GPIO_setMode(obj->gpioHandle,GPIO_Number_58,GPIO_58_Mode_SCITXDB);
  GPIO_setMode(obj->gpioHandle,GPIO_Number_29,GPIO_29_Mode_SCITXDA);
```

Adjust these lines to match the pins you intend to use. The `...` indicates other nearby GPIO setup code in the file.

---

## 9) HAL prototypes (hal.h)

In the HAL header (`hal.h`) add these declarations exactly as shown so other modules can call the SCI setup functions:

```c
//! \brief Sets up the sciA peripheral
//! \param[in] handle The hardware abstraction layer (HAL) handle
extern void HAL_setupSciA(HAL_Handle handle);
//! \brief Sets up the sciB peripheral
//! \param[in] handle The hardware abstraction layer (HAL) handle
extern void HAL_setupSciB(HAL_Handle handle);
```

---

## 10) SCI interrupts — declarations and implementation

Add the following declaration (in `hal.h`) to allow enabling SCI interrupts:

```c
//! \brief Enables the SCI interrupts
//! \details Enables the SCI interrupts in the PIE and CPU. Enables the
//! interrupt to be sent from the SCI peripheral.
//! \param[in] handle - the hardware abstraction (HAL) handle
extern void HAL_enableSciInts(HAL_Handle handle);
```

And add this implementation to `hal.c` **(copy verbatim)**:

```c
void HAL_enableSciInts(HAL_Handle handle)
{
  HAL_Obj *obj = (HAL_Obj *)handle;
  // enable the PIE interrupts associated with the SCI interrupts
  // enable SCIB RX interrupt in PIE
  PIE_enableInt(obj->pieHandle,PIE_GroupNumber_9,PIE_InterruptSource_SCIARX);
  // enable SCI RX interrupts
  // enable SCIB RX interrupt
  SCI_enableRxInt(obj->sciAHandle);
  // enable the cpu interrupt for SCI interrupts
  CPU_enableInt(obj->cpuHandle,CPU_IntNumber_9);
} // end of HAL_enableSciInts() function
```

---

## 11) ADC interrupt priority (ensure motor ISR > SCI ISR)

To make sure the Motor ADC ISR always has higher priority than the SCI RX ISR, modify `HAL_enableAdcInts(...)` in `hal.c` as follows **(copy verbatim)**:

```c
void HAL_enableAdcInts(HAL_Handle handle)
{
  HAL_Obj *obj = (HAL_Obj *)handle;


  // enable the PIE interrupts associated with the ADC interrupts
  // Default
  //PIE_enableAdcInt(obj->pieHandle,ADC_IntNumber_1);
  PIE_enableAdcInt(obj->pieHandle,ADC_IntNumber_1HP);

  // enable the ADC interrupts
  ADC_enableInt(obj->adcHandle,ADC_IntNumber_1);


  // enable the cpu interrupt for ADC interrupts
  // Default
  //CPU_enableInt(obj->cpuHandle,CPU_IntNumber_10);
  CPU_enableInt(obj->cpuHandle,CPU_IntNumber_1);
  return;
} // end of HAL_enableAdcInts() function
```

---

## 12) Init vector table and ISR wiring (hal.h, main.h)

In the HAL init vector setup, replace or augment the default ADC callback wiring so that the high priority ADC vector is used and the SCI RX ISR is assigned. Example changes (insert in `HAL_initIntVectorTable(...)`):

```c
  // Default
  //pie->ADCINT1 = &mainISR;
  pie->ADCINT1_HP = &mainISR;
  //Added
  pie->SCIRXINTA = &sciARxISR;
```

Also add the SCI RX ISR prototype to the globals section in `hal.h`:

```c
//Added
extern interrupt void sciARxISR(void);
```

And add the SCI-A ISR prototype to the function prototypes in `main.h`:

```c
//! \brief The SCI-A receive interrupt service (ISR) routine
//!
interrupt void sciARxISR(void);
```

---

## 13) SCI UART module architecture

TBA

---

# Troubleshooting

- If CCS fails to locate MotorWare headers or drivers, check that your `motorware_1_01_00_18` directory is placed under the same parent directory as the project (as described earlier) so the relative paths remain valid for include/linking.
- If SCI interrupts don't fire, verify:
  - The SCI clocks are enabled (`CLK_enableSciaClock` / `CLK_enableScibClock`).
  - The GPIO pins match the SCIA/SCIB mapping you’re using.
  - PIE and CPU interrupt numbers are enabled and match the MCU reference manual.
- Adjust baud rate if your board LSPCLK differs from the assumed 90 MHz.
- When changing HAL structures or prototypes in MotorWare code, prefer to make minimal edits and keep backups of original files.

---

