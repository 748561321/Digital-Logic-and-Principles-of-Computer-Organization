#include "sys.h"


char hello[]="Hello World!\n";
char tiaoshi[]="= = = tiao shi = = = =";




int main();

//setup the entry point
void entry()
{
    asm("lui sp, 0x00120"); //set stack to high address of the dmem
    asm("addi sp, sp, -4");
    main();
}

int main()
{
    vga_init();
    //char buf[100];
    //putstr(hello);
    char mingling[]=">>>";
    putstr(mingling);
    while(1)
    {
      
       //int c=getc();
       //putstr(itoa(c,buf));
       //putstr(endl);
    

       //putstr(tiaoshi);

       char ch=getch();
       putcom(ch);

       
       //putstr(endl);
    }
    return 0;
}