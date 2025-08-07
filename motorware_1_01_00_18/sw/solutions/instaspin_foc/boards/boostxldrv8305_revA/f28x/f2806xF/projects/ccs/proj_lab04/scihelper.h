//#include <math.h>
#include <stdint.h>
#include "sw/modules/math/src/32b/math.h"
#include <stdlib.h>
#include "sw/drivers/sci/src/32b/f28x/f2806x/sci.h"
//#include "hal_obj.h"
#include "sw/modules/iqmath/src/32b/IQmathLib.h"
#include "hal.h"
#include "sw/solutions/instaspin_foc/src/main.h"


int serial_tryReadLine(char *buf, int bufSize,uint16_t *rxHead, uint16_t *rxTail, char *rxBuf);
void serial_tryParseCmd(char *line, uint16_t *rxHead, uint16_t *rxTail, char *rxBuf, HAL_Handle halHandle, volatile MOTOR_Vars_t *motorVars);
