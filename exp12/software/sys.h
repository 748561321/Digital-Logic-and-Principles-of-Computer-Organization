#pragma once
#define VGA_START    0x00200000
//#define VGA_LINE_O   0x00210000
#define VGA_MAXLINE  64
//#define LINE_MASK    0x003f
#define VGA_MAXCOL   70
#define KEY_TAIL     0x00300020
#define KEY_START    0x00300000
#define SIGN_SHIFT   0x00300021
#define SIGN_CAPS    0x00300022

//#define TIME_ms      0x00400001
#define TIME_ADDR    0x00400000
#define LINE_0       0x00400001
#define SCR_MAXLINE  30//滚屏支持的行数
#define COLOR_ADDR   0x00480000  //001

#define LED_0        0x00500000  //0-9


void vga_line_add();
void putstr(char* str);
void putch(char ch);
void putcom(char ch);

void vga_init(void);
//int getc();
char getch();
char getdebug();
char tran_ascii(int key_code);
char *itoa(int i, char *a) ;
int htob(char *h);//十六进制字符串变为十进制数字
char* itoa_10(char* res,int num); //把十进制数字转换成字符串
char* itoa_long_10(char* res,long long int num);

unsigned int __udivsi3(unsigned int a, unsigned int b);
unsigned int __umodsi3(unsigned int a, unsigned int b);
int __divsi3(int a, int b) ;
int __modsi3(int a,int b) ;
long long int _long_divsi3(long long int a, int b) ;
long long int _long_modsi3(long long int a,int b) ;
unsigned int __mulsi3(unsigned int a, unsigned int b) ;

long long int fib(int n);

int make_token(char *e);
int expr(char *e,int *success);
int eval(int p,int q,int * success);
int check_parentheses(int p,int  q,int * success);
int isp( char op_type);

void deal_com(char * com );


void g2048();
void order(int end, int i, int v, int map[]);
void move(int i, int v, int map[]);

void srand();
int rand();

void snake();
void sleep();
void sleep2();

int abs(int i);
int sum(int v, int l, int* W, int* S, int* m);
void chess();

int _kbhit();

int move2(int* v, int l);
void russia();

int init();
void mazz();