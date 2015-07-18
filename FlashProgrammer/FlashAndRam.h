#ifndef FLASHANDRAM_H_
#define FLASHANDRAM_H_
#include <stdio.h>
#include <stdlib.h>
//#include <winsock.h>
#include <windows.h>
#include <string.h>
#include <string.h>
#include <conio.h>
//#include <iostream>
//#include <fstream>
#include <queue>
using namespace std;

//#pragma comment(lib, "ws2_32.lib")

class FlashAndRam{
public:
    FlashAndRam(char* com_name="COM1",char* filename="kernel.dat",unsigned int address=0,unsigned int final_addr=0,int mode=1);
    //FlashAndRam(char* com_name,char* filename,int mode);
    ~FlashAndRam();
    void send_com();
    int readKernel();    
    void read_com();
    char* com_name;
    char* file_name;
    int mode;
    queue<unsigned char> kernel_data;
    HANDLE com;
    FILE* load_file;
    FILE* store_file;
    unsigned int addr;
    unsigned int f_addr;
};
#endif // FLASHANDRAM_H
