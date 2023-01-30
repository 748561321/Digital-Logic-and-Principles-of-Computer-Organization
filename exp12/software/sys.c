#include "sys.h"
char endl[]="\n";
char normal[256]={' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ','`',' ',' ',' ',' ',' ',
                  ' ','q','1',' ',' ',' ','z','s','a','w',
                  '2',' ',' ','c','x','d','e','4','3',' ',
                  ' ',' ','v','f','t','r','5',' ',' ','n',
                  'b','h','g','y','6',' ',' ',' ','m','j',
                  'u','7','8',' ',' ',',','k','i','o','0',
                  '9',' ',' ','.','/','l',';','p','-',' ',
                  ' ',' ','\'',' ','[','=',' ',' ',' ',' ',
                  10,']',' ','\\',' ',' ',' ',' ',' ',' ',
                  ' ',' ',8,' ',' ','1',' ','4','7',' ',
                  ' ',' ','0','.','2','5','6','8',' ',' ',
                  ' ','+','3',',','*','9',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',};
char shift[256]={ ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ','~',' ',' ',' ',' ',' ',
                  ' ','Q','!',' ',' ',' ','Z','S','A','W',
                  '@',' ',' ','C','X','D','E','$','#',' ',
                  ' ',' ','V','F','T','R','%',' ',' ','N',
                  'B','H','G','Y','^',' ',' ',' ','M','J',
                  'U','&','*',' ',' ','<','K','I','O',')',
                  '(',' ',' ','>','?','L',':','P','-',' ',
                  ' ',' ','\"',' ','{','+',' ',' ',' ',' ',
                  10,'}',' ','\\',' ',' ',' ',' ',' ',' ',
                  ' ',' ',8,' ',' ','1',' ','4','7',' ',
                  ' ',' ','0','.','2','5','6','8',' ',' ',
                  ' ','+','3',',','*','9',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',
};
char caps[256]={' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ','`',' ',' ',' ',' ',' ',
                  ' ','Q','1',' ',' ',' ','Z','S','A','W',
                  '2',' ',' ','C','X','D','E','4','3',' ',
                  ' ',' ','V','F','T','R','5',' ',' ','N',
                  'B','H','G','Y','6',' ',' ',' ','M','J',
                  'U','7','8',' ',' ',',','K','I','O','0',
                  '9',' ',' ','.','/','L',';','P','-',' ',
                  ' ',' ','\'',' ','[','=',' ',' ',' ',' ',
                  10,']',' ','\\',' ',' ',' ',' ',' ',' ',
                  ' ',' ',8,' ',' ','1',' ','4','7',' ',
                  ' ',' ','0','.','2','5','6','8',' ',' ',
                  ' ','+','3',',','*','9',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                  ' ',' ',' ',' ',' ',' ',};
char caps_shift[256]={  ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ','~',' ',' ',' ',' ',' ',
                        ' ','q','!',' ',' ',' ','z','s','a','w',
                        '@',' ',' ','c','x','d','e','$','#',' ',
                        ' ',' ','v','f','t','r','%',' ',' ','n',
                        'b','h','g','y','^',' ',' ',' ','m','j',
                        'u','&','*',' ',' ','<','k','i','o',')',
                        '(',' ',' ','>','?','l',':','p','-',' ',
                        ' ',' ','\"',' ','{','+',' ',' ',' ',' ',
                        10,'}',' ','|',' ',' ',' ',' ',' ',' ',
                        ' ',' ',8,' ',' ','1',' ','4','7',' ',
                        ' ',' ','0','.','2','5','6','8',' ',' ',
                        ' ','+','3',',','*','9',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
                        ' ',' ',' ',' ',' ',' ',
};
char fib2[100][32]={
"0",
"1",
"1",
"2",
"3",
"5",
"8",
"13",
"21",
"34",
"55",
"89",
"144",
"233",
"377",
"610",
"987",
"1597",
"2584",
"4181",
"6765",
"10946",
"17711",
"28657",
"46368",
"75025",
"121393",
"196418",
"317811",
"514229",
"832040",
"1346269",
"2178309",
"3524578",
"5702887",
"9227465",
"14930352",
"24157817",
"39088169",
"63245986",
"102334155",
"165580141",
"267914296",
"433494437",
"701408733",
"1134903170",
"1836311903",
"2971215073",
"4807526976",
"7778742049",
"12586269025",
"20365011074",
"32951280099",
"53316291173",
"86267571272",
"139583862445",
"225851433717",
"365435296162",
"591286729879",
"956722026041",
"1548008755920",
"2504730781961",
"4052739537881",
"6557470319842",
"10610209857723",
"17167680177565",
"27777890035288",
"44945570212853",
"72723460248141",
"117669030460994",
"190392490709135",
"308061521170129",
"498454011879264",
"806515533049393",
"1304969544928657",
"2111485077978050",
"3416454622906707",
"5527939700884757",
"8944394323791464",
"14472334024676220",
"23416728348467684",
"37889062373143900",
"61305790721611580",
"99194853094755490",
"160500643816367070",
"259695496911122560",
"420196140727489660",
"679891637638612200",
"1100087778366101900",
"1779979416004714000",
"2880067194370816000",
"4660046610375530000",
"7540113804746346000"
};

char* led=(char *)LED_0;


char tokens[32][32];
int nr_token=0;

char space[]="  ";

char *vga_start = (char*) VGA_START;
char *key_tail = (char *)KEY_TAIL;
char *key_buf = (char *)KEY_START;


char *time =(char *) TIME_ADDR;
//char *time_ms=(char *) TIME_ms;
char *sign_caps=(char *)SIGN_CAPS;
char *sign_shift=(char *)SIGN_SHIFT;

char *line_0=(char *)LINE_0;

int shell_line=0;

int start_line=0;//LINE_0只有写没有读
int  vga_line=0;
int  vga_ch=0;
char head=0;

char * color_addr=(char *)COLOR_ADDR;

char command[1000];
int cnt=0;

void vga_init(){
    vga_line = 0;
    vga_ch =0;
    shell_line=0;
    start_line=0;
    *line_0 = 0;
    for(int i=0;i<VGA_MAXLINE;i++)
        for(int j=0;j<VGA_MAXCOL;j++)
            vga_start[ (i<<6)+(i<<2)+(i<<1)+j ] =0;//64+4+2
}

void vga_line_add()
{
   vga_line++;
   if((vga_line&0x3f)>= ((SCR_MAXLINE+start_line) & 0x3f) )
   {
     start_line++;
     *line_0=(char)(start_line&0x3f);
     
     for(int i=0;i<VGA_MAXCOL;i++)
      {
        vga_start[(((start_line&0x3f)-1)<<6)+(((start_line&0x3f)-1)<<2)+(((start_line&0x3f)-1)<<1)+i] ='\0';//debug
      }

   }
}

void putch(char ch)//系统输出
{
  if(ch==8) //backspace
  {
    char wrong[]="assert wrong!\n";
    putstr(wrong);

    // else
    // {
    //   if(vga_line>0)
    //   {
    //     vga_line--;
    //     vga_ch=VGA_MAXCOL-1;
    //   }
    // }
      return;
  }
  if(ch==10) //enter
  {
    //TODO
   
    
    vga_line_add();
    shell_line=vga_line;
    //滚屏待处理
    vga_ch=0;
    return;
  }
  vga_start[ ((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch] = ch;
  vga_ch++;
  if(vga_ch>=VGA_MAXCOL)
  {
     vga_line_add();
    vga_ch=0;
     //TODO
  }
  return;
}

void putcom(char ch)//按键
{
    if(ch==8) //backspace
  {
    if(vga_ch>3)
    {
      vga_ch--;
      vga_start[((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch]='\0';

      if(vga_ch==3 && vga_line==shell_line)
      vga_start[((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch-1]='>';
      else
      vga_start[((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch-1]=command[cnt-2];

      //char h =vga_start[(vga_line<<6)+(vga_line<<2)+(vga_line<<1)+vga_ch-1];
      //vga_start[(vga_line<<6)+(vga_line<<2)+(vga_line<<1)+vga_ch-1]=h;
      cnt--;
      command[cnt]='\0';
      
    }
    else if(vga_line!=shell_line)
    {
      if(vga_ch>0) 
      {
        vga_ch--;
        vga_start[((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch]='\0';

        vga_start[((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch-1]=command[cnt-2];

        cnt--;
        command[cnt]='\0';


      }
      else
      {
        vga_ch=VGA_MAXCOL-1;
        vga_line--;
        vga_start[((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch]='\0';
        vga_start[((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch-1]=command[cnt-2];

        cnt--;
      command[cnt]='\0';
      }

    }
    // else
    // {
    //   if(vga_line>0)
    //   {
    //     vga_line--;
    //     vga_ch=VGA_MAXCOL-1;
    //   }
    // }
      return;
  }
  if(ch==10) //enter
  {
  
    command[cnt] = '\0';

    //TODO
      vga_line_add();
      shell_line=vga_line;
    //滚屏待处理
    vga_ch=0;

    deal_com(command);

    char mingling[]=">>>";
    putstr(mingling);

    // char startline[]="startline:";
    // char vgaline[]="vgaline:";
    // char buf[100];
    // putstr(startline);
    // putstr(itoa(start_line&0x3f,buf));
    // putstr(vgaline);
    // putstr(itoa(vga_line&0x3f,buf));

    cnt=0;
    command[cnt]='\0';

    return;
  }
  vga_start[ ((vga_line&0x3f)<<6)+((vga_line&0x3f)<<2)+((vga_line&0x3f)<<1)+vga_ch] = ch;
  vga_ch++;
  if(vga_ch>=VGA_MAXCOL)
  {
    //TODO
    vga_line_add();
    vga_ch=0;
    
     
  }
  return;
}

void putstr(char *str)
{
    for(char* p=str;*p!=0;p++)
      putch(*p);
}



// int getc()//得到扫描码
// {
//   int c;
//   while (head == *key_tail)//0x0030020
//     ;
//   do {
//     c = key_buf[head];
//   } while (c == 0x12 || c == 0x58);
//   //shift 和 cap 功能待添加
  
//   if (head == 0x1f)
//     head = 0;
//   else
//     ++head;
//   return c;
// }

char getch()//转换ascii
{
  int c;
  char tmp;
  while (head == *key_tail)//0x0030020
    ;
  //do {
    c = key_buf[head];
    key_buf[head] = '\0';
 // } while (c == 0x12 || c == 0x58);
  //shift 和 cap 功能待添加
  tmp = tran_ascii(c);
  if(tmp == ' ' && c != 0x29 ) tmp ='\0';

  if(tmp!='\0' && tmp != 8)
  {
    command[cnt]=tmp;
    cnt++;
  }

  if (head == 0x1f || *key_tail == 0)
    head = 0;
  else
    ++head;


  return tmp;
}

char tran_ascii(int key_code)
{
  if(*sign_caps&&*sign_shift) return caps_shift[key_code];
  else if(*sign_shift) return shift[key_code];
  else if(*sign_caps) return caps[key_code];
  else return normal[key_code];
}


char *itoa(int i, char *a) //把十六进制数字转换成十六进制字符串
{
  int count = 0;
  while (i != 0) //将i转为16进制
  {
    int tmp = i & 0xf; //末位
    if (tmp <= 9) 
    {
      tmp = tmp + '0';
    } 
    else //转为十六进制
    {
      tmp = tmp - 10 + 'a';
    }
    a[count] = (char)tmp;
    i >>= 4;
    ++count;
  }
  a[count] = '\0';

  int head = 0, tail = count - 1;//i的头尾
  
  while (head < tail) //首尾交换
  {
    char tmp = a[head];
    a[head] = a[tail];
    a[tail] = tmp;
    ++head;
    --tail;
  }
  return a;
}

int htob(char *h)//十六进制字符串变为十进制数字
{
  int number =0;
  int len;
  for(len=0; h[len]!='\0';len++);
  int base=1;
  for(int i=len-1;i>=0;i--)
  {
     if(h[i]>='0'  && h[i]<='9')
     {
       number += (h[i]-'0')*base;
     }
     else if(h[i]>='a' && h[i]<='f')
     {
       number+= (h[i]-'a'+10)*base;
     }
     base = base <<4;

  }
  return number;
}



char* itoa_10(char* res,int num)
{
    int temp = num;
    int cnt = 0;
    while (temp >= 1)
    {
        temp=__divsi3(temp, 10);
        cnt++;
    }
    //int x = 1;
    for (int i = 0; i < cnt; i++)
    {
       
        res[i] = (char)(__modsi3(num, 10) + '0');
        num = __divsi3(num, 10);
    }
    res[cnt] = '\0';
    int head = 0, tail = cnt - 1;
    while (head < tail) //首尾交换
    {
        char tmp = res[head];
        res[head] = res[tail];
        res[tail] = tmp;
        ++head;
        --tail;
    }
    return res;
}

char* itoa_long_10(char* res,long long int num)
{
    long long int temp = num;
    int cnt = 0;
    while (temp >= 1)
    {
        temp=_long_divsi3(temp, 10);
        cnt++;
    }
    //int x = 1;
    for (int i = 0; i < cnt; i++)
    {
       
        res[i] = (char)(_long_modsi3(num, 10) + '0');
        num = _long_divsi3(num, 10);
    }
    res[cnt] = '\0';
    int head = 0, tail = cnt - 1;
    while (head < tail) //首尾交换
    {
        char tmp = res[head];
        res[head] = res[tail];
        res[tail] = tmp;
        ++head;
        --tail;
    }
    return res;
}



void deal_com(char * com )
{
    // putstr(com);
    // char c= cnt + '0';
    // putch(c);
    // putstr(endl);
    // putch(com[cnt]);
    // putstr(endl);
//
    int flag[14]={0};  //0： hello 1：time 2:fib  3:wrong 4:color 5:cal 6:help 7:clear 8:led 9:g2048 10:snake 11:chess 12:russia 13:mazz

    if(cnt<=4)
    {
      flag[13]=1;
    }
    else
    {
      char ma[]="mazz";
      for(int i=0;i<cnt-1;i++)
      {
        if(com[i] != ma[i])
        flag[13] =1 ;
      }
    }

    if(cnt<=6)
    {
      flag[12]=1;
    }
    else
    {
      char te[]="russia";
      for(int i=0;i<cnt-1;i++)
      {
        if(com[i] != te[i])
        flag[12] =1 ;
      }
    }

    if(cnt<=5)
    {
      flag[11]=1;
    }
    else
    {
      char ch[]="chess";
      for(int i=0;i<cnt-1;i++)
      {
        if(com[i] != ch[i])
        flag[11] =1 ;
      }
    }

    if(cnt<=5)
    {
      flag[10]=1;
    }
    else
    {
      char sn[]="snake";
      for(int i=0;i<cnt-1;i++)
      {
        if(com[i] != sn[i])
        flag[10] =1 ;
      }
    }
     
    if(cnt<=5)
    {
      flag[9]=1;
    }
    else
    {
      char g2[]="g2048";
      for(int i=0;i<cnt-1;i++)
      {
        if(com[i] != g2[i])
        flag[9] =1 ;
      }
    }



    if(cnt!=6)
    {
      flag[8]=1;
    }
    else
    {
      
      char le[]="led";
      for(int i=0;i<3;i++)
      {
        if(com[i]!=le[i])
        {flag[8]=1;break;}
      }
      
      if(flag[8]==0)
      {
        if(com[3]!=' ') flag[3]=1;
        else
        {
          if(com[4]>='0' && com[4]<='9')
          {
            int x= com[4]-'0';
            *(led+x) = (char)1;
          }
          else flag[3]=1;
        }
      }
      
    }


    //输入hello cnt=6 : hello
    if(cnt<=5)
    {
      flag[0]=1;
    }
    else
    {
      char hello[]="hello";
      for(int i=0;i<cnt-1;i++)
      {
        if(com[i] != hello[i])
        flag[0] =1 ;//hello不行
      }
    }
   //time  5
    if(cnt<=4)
    {
      flag[1]=1;
    }
    else
    {
      char time[]="time";
      //输入time cnt=5
      for(int i=0;i<cnt-1;i++)
      {
        if(com[i] != time[i])
        {flag[1]=1 ;break;}
      }
    }
//   
    //输入fib 
    char fibnum2[32];
   // long long int fibnum=0;
    if(cnt<=5)
    {
      flag[2]=1;
    }
    else
    {
      

      char fi[]="fib";
      for(int i=0;i<3;i++)
      {
        if(com[i]!=fi[i])
        {flag[2]=1;break;}
      }
      if(flag[2]==0)
      {
        if(com[3]!=' ') {flag[3]=1;flag[2]=1;}
        int number=0;//10
        for(int i=4;i<cnt-1;i++)
        {
          if( com[i]>='0' && com[i]<='9' )
          {
            number = (number<<3) + (number<<1) + com[i] - '0';
          }
          else
          {
            flag[2]=1; 
            flag[3]=1;//输入有误
          }
        }
        if(flag[2]==0 && number!=0
          && number<=92
          )
        {
          //fibnum= fib(number);
          int j;
          for(j=0;fib2[number][j]!='\0';j++)
          {
          fibnum2[j]=fib2[number][j];
          }
          fibnum2[j]='\0';

        }
        else
        {
          flag[2]=1;
          flag[3]=1;
        }
      }
      
    }
    //输入 color
    if(cnt<=7)
    {
      flag[4]=1;      
    }
    else
    {
      char col[]="color";
      for(int i=0;i<=4;i++)
      {
        if(col[i]!=com[i])
        {
          flag[4]=1 ; break;
        }
      }
      if(flag [ 4] == 0)
      {
        // char red[]="red";
        // for(int i=0;i<=2;i++)
        // {
        //   if(red[i]!=com[i+6])
        //   {
        //     flag[3]=1;break;
        //   }
        // }
        // if(flag [3] ==0)
        // {
        //    *color_addr=(char)1;
        // }
        if(com[6]>='0' && com[6]<='7')
        {
          *color_addr=com[6];
        }
        else
        {
          flag[3]=1;
        }
      }
    }
    //输入 cal

    int cal_number;
    if(cnt<=5)
    {
      flag[5]=1;
    }
    else
    {
      char cal[]="cal";
      for(int i=0;i<=2;i++)
      {
          if(command[i]!=cal[i])
          flag[5]=1;
      }
      if(flag[5]==0)
      {
          char exp[100];
          for(int i=4;i<cnt-1;i++)
          {
            exp[i-4] =command [i];
          }
          exp[cnt-1-4]='\0';
          int f[1]={1};
          cal_number=expr(exp,f);
          //f=0 flag[3] = 1 flag [5] =1 
          flag[3]=1-f[0];
          flag[5]=1-f[0];
      }
    }

    //输入help
    if(cnt<=4)
    {
      flag[6]=1;
    }
    else
    {
       char help[]="help";
       for(int i=0;i<=3;i++)
       {
         if(com[i]!=help[i])
         {flag[6]=1;break;}
       }
    }

    //输入clear
    if(cnt<=5)
    {
      flag[7]=1;
    }
    else
    {
       char cle[]="clear";
       for(int i=0;i<=4;i++)
       {
         if(com[i]!=cle[i])
         {flag[7]=1;break;}
       }
    }

    // //debug
    // for(int i=0;i<=8;i++)
    // {
    //   if(flag[i])
    //   {
    //     char a[]="1";
    //     putstr(a);
    //   }
    //   else
    //   {
    //     char b[]="0";
    //     putstr(b);
    //   }
              
    // }
    // putstr(endl);
    
    if(flag[0]==0)
    {
      char temp[]="Hello World!\n";
      putstr (temp);
    }   
    else if(flag[1]==0)
    {
      char buf[100];

      int c=*time;
      c=c/1000;

      putstr(itoa_10( buf,  htob(itoa(c,buf))  ));

      putstr(endl);
    }
    else if(flag[2]==0)
    {//fib
    
        //char buf[100];
        //putstr(itoa_long_10(buf,fibnum));
        //putstr(endl);
        putstr(fibnum2);
        putstr(endl);
    }
    else if(flag[3]==1)
    {
      char wrong[]="Wrong or invalid input!\n";
      putstr(wrong);
    }
    else if(flag[4]==0)
    {     

    }
    else if(flag[5]==0)
    {
      char buf[100];
       if(cal_number<0)
       {
         putch('-');
         cal_number=-cal_number;
       }
       else if(cal_number==0)
       {
         putch('0');
       }
       putstr(itoa_10(buf,cal_number));
       putstr(endl);
    }
    else if(flag[6]==0)
    {
      //0： hello 1：time 2:fib  3:wrong 4:color 5:cal 6:help 7:clear 8:led 9:segn m
       

        putstr("===================COMMAND HELP=======================\n");
        putstr("help     : print COMMAND HELP\n");
        putstr("hello    : print hello\n");
        putstr("time     : print time\n");
        putstr("fib n    : calculate fib(n)\n");
        putstr("cal expr : calculate expression\n");
        putstr("clear    : clear the screen\n");
        putstr("led n    : turn on/off the led\n");
        putstr("g2048    : play the game 2048\n");
        putstr("snake    : play the game snake\n");
        putstr("chess    : play the game chess\n");
        putstr("russia   : play the game russia\n");
        putstr("mazz     : play the game mazz\n");
        putstr("======================================================\n");
    }
    else if(flag[7]==0)
    {
        vga_init();
    }
    else if(flag[8]==0)
    {

    }
    else if(flag[9]==0)
    {
        g2048();
    }
    else if(flag[10]==0)
    {
       snake();
    }
    else if(flag[11]==0)
    {
       chess();
    }
    else if(flag[12]==0)
    {
       russia();
    }
    else if(flag[13]==0)
    {
       mazz();
    }
    else
    {
      if(cnt!=1)
      {
        char un[]="Unknown command!\n";
        putstr(un);
      }
    }
//0： hello 1：time 2:fib  3:wrong 4:color 5:cal 6:help 7:clear 8:led 9:segn m

    // if(com == "hello")
    // {
    //   char temp[]="Hello World!\n";
    //   putstr (temp);
    // } 
    // if(com[0] == 'h')
    // {
    //   char temp[]="H\n";
    //   putstr (temp);
    // }
    // if(com[0]=='h' && com[1]== 'e')
    // {
    //   char temp[]="He\n";
    //   putstr (temp);
    // }
    // if(com[0]=='h' && com[1]=='e' && com[4]=='o')
    // {
    //   char temp[]="Hello\n";
    //   putstr (temp);
    // }
    // if(com[5]=='\0')
    // {
    //   char temp[]="Hello H\n";
    //   putstr (temp);
    // }

    // else 
    // {
    //   char un[]="Unknown command!\n";
    //   putstr(un);
    // }
}
long long int fib(int n)
{
    long long int  t1 = 0, t2 = 1, nextTerm;
 
    for (int i = 1; i <= n; ++i)
    {
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
    }
    return t1;
}


unsigned int __mulsi3(unsigned int a, unsigned int b) {
    unsigned int res = 0;
    while (a) {
        if (a & 1) res += b;
        a >>= 1;
        b <<= 1;
    }
    return res;
}

int __modsi3(int a,int b) {
    int bit = 1;
    int res = 0;

    while (b < a && bit && !((unsigned int)b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return a;
}

int __divsi3(int a, int b) {
    int bit = 1;
   int res = 0;

    while (b < a && bit && !((unsigned int)b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return res;
}

unsigned int __umodsi3(unsigned int a, unsigned int b) {
    unsigned int bit = 1;
    unsigned int res = 0;

    while (b < a && bit && !(b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return a;
}

unsigned int __udivsi3(unsigned int a, unsigned int b) {
    unsigned int bit = 1;
    unsigned int res = 0;

    while (b < a && bit && !(b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return res;
}

long long int _long_divsi3(long long int a, int b) 
{
   long long int bit = 1;
   long long int res = 0;

    while (b < a && bit && !((unsigned int)b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return res;
}
long long int _long_modsi3(long long int a,int b) 
{
   long long int bit = 1;
   long long int res = 0;

    while (b < a && bit && !((unsigned int)b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return a;
}


int expr(char *e,int *success)
{
   nr_token=0;
    if(make_token(e)==0)
    {
      *success=0;//putstr("tiaoshi1");
      return 0;
      
    }
    for(int i=0;i<nr_token;i++)
    {
      if(tokens[i][0]== '-')
      {
        if(i==0 || tokens[i-1][0] == '+' || tokens[i-1][0]=='-' || tokens[i-1][0]=='/'   || tokens[i-1][0]=='*' )
        tokens[i][0]='@';
      }
    }
    return eval(0,nr_token-1,success);
}


int make_token(char *e)
{
  for(int i=0;e[i]!='\0';i++)
  {
    
     if(e[i]>='0' && e[i]<='9')
     {
        int j=0;
        while(e[i] >= '0' && e[i]<= '9')
        {
           tokens[nr_token][j]=e[i];
           j++;i++;
        }
        i--;
        tokens[nr_token][j]='\0';
        nr_token++;
     }
     else if(e[i]=='+' || e[i]=='-' || e[i]=='*' || e[i]=='/'|| e[i] =='(' || e[i]==')')
     {
       tokens[nr_token][0]=e[i];
       tokens[nr_token][1]='\0';
       nr_token++;
     }
     else
     {
      // putstr("tiaoshi6:");
       //putch(e[i]);
       //putstr(endl);
       return 0;
     }
  }
  return 1;
}
int eval(int p,int q,int * success)
{
  if(*success == 0) return 0;
  if(p>q)
  {
    *success=0;return 0;
    
  }
  else if(p==q)
  {
     int number=0;
     for(int i=0;tokens[p][i]!='\0';i++)
     {
       number = (number<<3) + (number<<1) + tokens[p][i] - '0';
     }
     return number;
  }
  else if(check_parentheses(p, q,success) == 1)
  {
    return eval(p+1,q-1,success);
  }
  else
  {
    int cnt=0;
    char op_type='s';
    int op_position;
    for( int i=p;  i<q;  i++ )
    {
        if(tokens[i][0] == '(' ) cnt++;
        else if(tokens[i][0] == ')' ) cnt--;
        //cnt<0情况在前面处理了
        if(cnt>0) continue;
        //cnt==0
        if( isp(tokens[i][0]) <=  isp(op_type) )
        {
            op_type=tokens[i][0];
            op_position=i;
        }
    }


    if(op_type=='s') {*success=0;return 0;}
    if(op_type=='@')
    {
        int val=eval(op_position+1,q,success);
        return -val;
    }
    else 
    {
        int val1 = eval(p, op_position - 1,success);
        int val2 = eval(op_position + 1, q,success);
        
        //printf (" %d %d    ",val1 ,val2);
        
        switch(op_type) 
        {
            case '+': return val1 + val2;
            case '-': return val1 - val2;
            case '*': return val1 * val2;
            case '/': return val1 / val2;
            default: *success=0;return 0;
        }
    }
  }
}
int check_parentheses(int p,int  q,int *success)
{
  if(tokens[p][0]!='(') return 0;
  if(tokens[q][0]!=')') return 0;
  int cnt=0;
  for(int i=p+1;i<q;i++)
  {
      if(tokens[i][0]=='(') cnt++;
      else if(tokens[i][0]==')') cnt--;
      if(cnt<0) {*success=0;return 0;}
  }
  return 1;
}
int isp( char op_type)
{
    switch (op_type)
    {
        case '+':return 0;
        case '-':return 0;
        case '*':return 1;
        case '/':return 1;
        case '@':return 2;
        case '&':return 2;
        case 's':return 3;//初始值
        default:return 3;//不是符号
    }
}

int score=0;int k=0;int seed=0;
void move(int i, int v, int map[])
{
	if (i + v < 0 || 15 < i + v || !map[i])
		return;
	if ((v == 1 || v == -1) && i / 4 - (i + v) / 4)
		return;
	if (map[i + v] == map[i])
  {
		map[i + v] *= -2; score += map[i]; map[i] = k = 0;
  }
	if (!map[i + v])
  {
		map[i + v] = map[i];map[i] = k = 0;move(i + v, v, map);
  }
}
void order(int end, int i, int v, int map[])
{
	for (int begin = end == 16 ? 0 : 15; begin - end; begin += i)
		move(begin, v, map);
}
void g2048()
{
	int map[16] ;
  score=0;k=0;seed=0;
  for(int i=0;i<=15;i++) map[i]=0;
  int game = 1,  i, j;
  char c;
	const char *wall[4] = { "\n----- ----- ----- -----\n","|","|","|" };
	for (srand(),
   c ='0', j = 0; game; j = k = 1, c = getch()
   ) {
		if (c == 'a' || c == 'w')
			order(16, 1, c == 'a' ? -1 : -4, map);
		else if (c == 'd' || c == 's')
			order(-1, -1, c == 'd' ? 1 : 4, map);
    else if(c=='q')
    {
      vga_init();
      return ;
    }
		for (i = 0; i < 16; i++)
    {
      if(map[i]<0) map[i] = -map[i];
      //map[i] || (j = 0);
      if(map[i]==0) j=0;
    }
		do if (i = rand() % 16, j || k)
			break;
		while (map[i] || (map[i] = rand() % 5 ? 2 : 4, 0));
		vga_init();
		for (i = 0; j && (i < 15 || (game = 0)); i++)
			if (   (i < 12 && map[i] == map[i + 4]) ||
				 ( ((i + 1 )& 3) && map[i] == map[i + 1] )   )
        break;
		if (!game)
    {
      char x[]="Game over!";
			putstr(x);
    }
		else
    {
			//cout << "score:" << score;
      char x[]="score: ";
      putstr(x);
      char buf[100];
      putstr( itoa_10 (buf,score));
    }
		for (i = 0; i < 16; i++)
    {
		//	cout << wall[i & 3] <<"    "<< map[i];
      putstr(wall[i&3]);
      char x[]="     ";
      char x1[]="    ";
      char x2[]="   ";
      char x3[]="  ";
      char x4[]=" ";
      char x5[]="";

      if(map[i]>10000) putstr(x5);
      else if(map[i]>1000) putstr(x4);
      else if(map[i]>100) putstr(x3);
      else if(map[i]>10) putstr(x2);
      else if(map[i]>0) putstr(x1);
      else putstr(x);

      char buf[100];
      putstr(itoa_10(buf,map[i]));
    }
    if(!game)
    {
      putstr(endl);
    }
	}
}


void srand()
{
  seed= 41;
}
int rand()
{
  seed = ((seed * 214013 + 2531011) >> 16) & 0x7fff;
	if (seed == 41) seed = 40;
	return seed;
}
void sleep()
{
  int t=*time;
  int c=*time;
  while(   t+100>=c   ) c=*time;
  return;
}
void sleep2()
{
  int t=*time;
  int c=*time;
  while(   t+50>=c   ) c=*time;
  return;
}

int _kbhit()
{
if (head!= *key_tail) return 1;
else return 0;
}

void snake() {
    int W = 20, S = W * W, z[2] = { 0 }, l = 3, i,   * p, f;
    char C;char c='D';
    int m[1000];
    for (int i = 0; i < S; i++)
        m[i] = 0;
    for (C = m[1] = -1; C - 27; sleep()) 
    {
        if (head!= *key_tail)
        {
            char t=getch();
            C = t & 95;
            C - 65 && C - 68 && C - 83 && C - 87 || (C ^ c) & 20 ^ 4 && (c = C);
            if(t=='q') {vga_init();return ;}
        }
        p = z + !!(c & 2);
        *p += c / 3 & 2;
        *p = (-- * p + W) % W;
        f = 1;
        vga_init();
        *(p = m + *z + z[1] * W) > 0 && (C = 27);
        for (; *p && (m[i = rand() % S] || (--m[i], ++l, --f)););
        for (i = 0, *p = l; i < S; )
        {
            
           if (m[i] > 0)
            {
                m[i] -= f;
                char tmp[]= "()";
                putstr(tmp);
            }
            else
                if (m[i])
                {
                  char tmp[]="00";
                  putstr(tmp);
                }
                else
                {
                  char tmp[]="  ";
                  putstr(tmp);
                }
              

            if(!(++i % W))  {char tmp[]="|\n";putstr(tmp);}

        }
    }
}

int abs(int i)
{
  if(i>=0) return i;
  else return -i;
}
int sum(int v, int l, int* W, int* S, int* m)
{
    return (abs(v % *W - (v + l) % *W) - *W + 1 && v + l >= 0 && v + l <*S) &&
        m[v] == m[v + l] ? 1 + sum(v + l, l, W, S, m) : 0;
}
void chess()
{
    int W = 13, S, z = 0, c = 1, r = 2, i, j;
    int m[1000];
    S = W * W;
    for (int i = 0; i < S; i++)
        m[i] = 0;
    for (; r < 4 && c - 27; )
    {
        c - 68 || ++z, c - 65 || --z, c - 83 || (z += W), c - 87 || (z -= W);
        vga_init();
        if (z = (z + S) % S, i = 2, !c && !m[z])
            for (m[z] = r ^= 3; j = i % 3 - 1 + i / 3 * W, i < 6; ++i)
                sum(z, j, &W, &S, m) + sum(z, -j, &W, &S, m) > 3 && (r ^= 3, i = r += 4);
        for (i = 0; i < S; )
        {
            // cout << " >"[i == z] << " 0@"[m[i]];
            if (i == z)
            {
                putstr(">");
            }
            else

            {
                putstr(" ");
            }
            if (m[i]==1)
            {
                putstr("0");
            }
            else if (m[i] == 2)
            {
                putstr("X");
            }
            else
            {
                putstr(" ");
            }
            if(!(++i%W))
            {
              char buf[10];
              putstr(itoa_10(buf,i/W));
              putstr(endl);
            }
        }
        for (i = 0; i < W; ++i)
            {
              putstr(" ");
              char tmp=(char)(97+i);
              putch(tmp);
            }
        if (r & 1)
            putstr("\nWhite ");
        else
            putstr("\nBlack ");
        if (r >= 4)
            putstr("win!\n");

        char t=getch();
        if(t=='q') {vga_init();return;}    
        c = t  & 95;
    }
}


#define Get(C) for (C, i = n[T]; j = X + i % 4, k2 = Y + i / 4 % 4, i; i >>= 4)
int W = 10, H = 25, S, i, j, k2, c, d = 0, X = 0, Y = 0, T = 0, n[] = {
	51264, 12816, 21520, 21520, 25872, 34113, 21537, 38208, 25921, 38481,
	38484, 38209, 25922, 43345, 34388, 38160, 25920, 38177, 42580, 38993 }, m[1000];
int move2(int* v, int l)
{
	Get(*v += l)(j < 0 || j >= W || k2 >= H || m[k2 * W + j]) && (c = 0);
	return c ? 1 : (*v -= l, v == &Y && (c = -1));
}
void russia()
{
  W = 10; H = 25; d = 0; X = 0; Y = 0; T = 0;
	for (int i = 0; i < 1000; i++)
		m[i] = 0;
	S = W * H;
	for (; c - 27; sleep2(),vga_init() )
	{
    if(_kbhit())
    {
       char t=getch();
       if(t=='q') {   vga_init();return ;}
       c=t&95;
    }
    else
    {
      c=1;
    }

    i = n[T];
    for (; j = X + i % 4, k2 = Y + i / 4 % 4, i; i >>= 4)
     m[k2 * W + j] = 0;
		c ^ 65 || move2(&X, -1), c ^ 68 || move2(&X, 1), c ^ 83 || move2(&Y, 1);
		c ^ 87 || (i = T < 8 ? 1 : 3, move2(&T, T& i^ i ? 1 : -i));
		Get(++d - 10 || (d = 0, c = 1, move2(&Y, 1))) 
    m[k2 * W + j] = 1;
		if (c == -1 && !(Y || (c = 27), T = rand() % 20, Y = X = 0))
			for (j = W, i = S - 1; j -= m[i], i; i-- % W || (j = W))
				for (j || (k2 = i += W); !j && (--k2 >= W); m[k2] = m[k2 - W]);
		for (; i < S; //++i % W || _cputs("|\n")
    )
    {
        if(m[i])
        {
          putstr("[]");
        }
        else
        {
          putstr("  ");
        }
        if(!(++i%W))
        {
          putstr("|\n");
        }

    }
    
	}
}


int W3 = 15, S3, c3 = 81, i3, j3, k3, l3[4] = { 1, -1 }, m3[1000], L3[1000];
int init() {
	for (i3 = S3; i3-- || (c3 = m3[i3 = rand() % S3] == 2, k3 = 0);)
		m3[i3] = 2 + ((i3 + 1) % W3 < 2) + (i3 % (S3 - W3) < W3);
	for (c3 && (L3[k3++] = i3); k3 && (j3 = L3[i3 = rand() % k3], 1);)
		for (L3[i3] = L3[--k3], i3 = m3[j3] & 3 ? m3[j3] = 0 : 4; i3 < 4; ++i3)
			c3 = j3 + l3[i3], m3[c3] & 3 && ++m3[c3], m3[c3] & 3 && (L3[k3++] = c3);
	for (i3 = c3 ? W3 : S3; i3 >= S3 ? init(), 0 : m3[i3 - W3]; i3 += W3)
		m3[i3] & 3 | m3[S3 - 1 - i3] & 3 || (m3[j3 = i3] = m3[k3 = S3 - 1 - i3] = 0);
	return 0;
}
void mazz()
{
  W3 = 15;c3 = 81;
	for (int i1 = 0; i1 < 1000; i1++)
		m3[i1] = 0;
	for (int i2 = 0; i2 < 1000; i2++)
		L3[i2] = 0;
	S3 = W3 * W3;
	srand();
	l3[2] -= l3[3] = W3;
	for (; c3 - 81 && j3 - k3 ? 0 : init(), c3 - 27; )
	{
		c3 - 87 || m3[j3 - W3] || (j3 -= W3), c3 - 68 || m3[j3 + 1] || ++j3;
		c3 - 83 || m3[j3 + W3] || (j3 += W3), c3 - 65 || m3[j3 - 1] || --j3;
    vga_init();
		for (i3 = 0; i3 < S3; )
    {

      if(i3-j3==0)
      {
        putstr("<>");
      }
      else
      {
        if(m3[i3])
        {
          putstr("[]");
        }
        else
        {
          putstr("  ");
        }
      }
      

      if(!(++i3%W3))
      {
        putstr(endl);
      }
    }
	  char t=getch();
    if(t=='e')
    {
      vga_init();return ;
    }
    c3 = t& 95;
  }
}