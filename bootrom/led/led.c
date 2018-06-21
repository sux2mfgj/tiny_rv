#include <stdint.h>
#define LED_ADDRESS 0x40000000

void main(void)
{
    *(uint8_t*)(LED_ADDRESS) = (uint8_t)1;
}
