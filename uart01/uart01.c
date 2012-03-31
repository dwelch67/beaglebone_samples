
extern void dummy ( unsigned int );
extern void PUT8 ( unsigned int, unsigned int );
extern void PUT16 ( unsigned int, unsigned int );
extern void PUT32 ( unsigned int, unsigned int );
extern unsigned int GET8 ( unsigned int );
extern unsigned int GET16 ( unsigned int );
extern unsigned int GET32 ( unsigned int );

#define U0RBR       0x44E09000
#define U0THR       0x44E09000
#define U0LSR       0x44E09014

//-------------------------------------------------------------------
void uart_putc ( unsigned int x )
{
    while (( GET16(U0LSR) & (1<<5)) == 0) continue;
    PUT16(U0THR,x);
}
//-------------------------------------------------------------------
unsigned int uart_getc ( void )
{
    while (( GET16(U0LSR) & (1<<0)) == 0) continue;
    return(GET16(U0RBR));
}
//-------------------------------------------------------------------
void hexstrings ( unsigned int d )
{
    //unsigned int ra;
    unsigned int rb;
    unsigned int rc;

    rb=32;
    while(1)
    {
        rb-=4;
        rc=(d>>rb)&0xF;
        if(rc>9) rc+=0x37; else rc+=0x30;
        uart_putc(rc);
        if(rb==0) break;
    }
    uart_putc(0x20);
}
//-------------------------------------------------------------------
void hexstring ( unsigned int d )
{
    hexstrings(d);
    uart_putc(0x0D);
    uart_putc(0x0A);
}
//-------------------------------------------------------------------
void uart_string ( char *s )
{
    while(*s)
    {
        uart_putc(*s);
        s++;
    }
}
//-------------------------------------------------------------------
void notmain ( void )
{
    hexstring(0x12345678);
    uart_string("Hello World!\r\n");
    hexstring(0x12345678);
    while(1)
    {
        uart_putc(uart_getc());
    }
}
//-------------------------------------------------------------------
//-------------------------------------------------------------------

