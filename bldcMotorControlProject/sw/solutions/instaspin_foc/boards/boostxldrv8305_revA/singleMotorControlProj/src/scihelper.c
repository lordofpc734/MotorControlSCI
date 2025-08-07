// Module for SCI UART Reception for the TMS320F28069M MCU

#include "scihelper.h"
#include <string.h>
#include <strings.h>


#define RX_BUF_SIZE  32


float_t serialCurrentRef;
_iq iq24SerialCurrentRef;

// Attempts to read a valid string from the UART receive buffer populated by the sciARxISR interrupt routine
// A valid string is any set of chars with a carriage return or newline terminator (\r, \n)
// Returns length >0 if a full line was found (and writes it into buf),
// or 0 if still waiting for CR/LF.
int serial_tryReadLine(char *buf, int bufSize, uint16_t *rxHead, uint16_t *rxTail, char *rxBuf)
{
    static int idx = 0;

    // no data
    if(*rxHead == *rxTail)
        return 0;

    // pull as many chars as are available, up to bufSize-1
    while((*rxHead != *rxTail) && idx < bufSize-1) {
        char c = rxBuf[*rxTail];
        *rxTail = (*rxTail + 1) & (RX_BUF_SIZE-1);

        if(c=='\r' || c=='\n') {
            buf[idx] = '\0';
            int outLen = idx;
            idx = 0;          // reset for next line
            return outLen;
        }
        buf[idx++] = c;
    }

    // If we filled the buffer without seeing newline, you can:
    // - return idx (a “partial” line), or
    // - discard and reset idx=0, or
    // - clamp idx=bufSize-1 and NUL-terminate.
    return 0;
}

// Attempts to parse string rovided by serial_tryReadLine
// Expects string in the following format: "XXX&N.N--N\r" where X is 0 OR 1 and N an integer, e.g "111&0.345\r" 
// Command Structure:
// SysEn	Run	ForceAngle	<DELIM>    IqRef_A	
// 1	    1	1		       &       0.345
// NOTE: No part of the command structure can be omitted.
void serial_tryParseCmd(char *line, uint16_t *rxHead, uint16_t *rxTail, char *rxBuf, HAL_Handle halHandle, volatile MOTOR_Vars_t *motorVars){
    
    // Holds string buffer containing the binary values for gMotorVars flags
    char commandReg[4];
    // Holds string buffer containing the float value for iqRef_A
    char currentStr[16];
    
    int len = serial_tryReadLine(line,RX_BUF_SIZE, rxHead, rxTail, rxBuf);
        if (len <= 0){
            return; // Nothing to parse
        }

        // Find position of the delimiter '&'
        char *sep = strchr(line, '&');
        if (!sep) {
            return; // No delimiter, Invalid command syntax
        }

        // Replace delimiter with string terminator
        *sep = '\0';
        // Pointer to line buffer
        char *cmd = line;
        // Pointer to line buffer, but at index of delimiter + 1 (The float half of the command)
        char *iValue = sep+1;

        // Copy contents of the first half (cmd) of line buffer to a new buffer and terminate
        strncpy(commandReg, cmd, sizeof(commandReg)-1);
        commandReg[sizeof(commandReg)-1] = '\0';

        // Copy contents of the second half (iValue) of line buffer to a new buffer and terminate
        strncpy(currentStr, iValue, sizeof(currentStr)-1);
        currentStr[sizeof(currentStr)-1] = '\0';

        char *endptr;

        // Convert currentStr string to float
        serialCurrentRef = strtof(currentStr, &endptr);

        // Convert float to Q24 representation
        iq24SerialCurrentRef = _IQ(serialCurrentRef);

        // Assign command bits to gMotorVars struct members
        motorVars->IqRef_A =                iq24SerialCurrentRef;
        motorVars->Flag_enableSys =         commandReg[0] - '0'; // Convert char at index to int
        motorVars->Flag_Run_Identify =      commandReg[1] - '0';
        motorVars->Flag_enableForceAngle =  commandReg[2] - '0';

}