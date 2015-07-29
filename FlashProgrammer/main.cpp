#include <stdio.h>
#include <string.h>
#include "FlashAndRam.h"

char msg[]="flashAndram [options]\n\
Options:\n\t\
-h: help message\n\t\
-c COM_NAME: the name of the com\n\t\
-r filename address: write the file to ram in the address\n\t\
-f filename address: write the file to flash in the address\n\t\
-k addr1 addr2 filename [-s]: check the content from addr1(hex) to addr2(hex) (-s show data)\n\t\
\nnotes:no support to write ram and flash or check memory at the same time\n";

int main(int argc,char** argv)
{	
	char* com_name=NULL;
	char* filename=NULL;
	unsigned int addr=0;
	unsigned int f_addr=0;
	int mode = 1;
	int flag = 1;
	int flagx = 1;
	for(int i=1;i<argc;i++)
	{
		if(strcmp(argv[i],"-h")==0)
		{
			printf("%s\n",msg);
			flag = 0;
		}
		else
		{
			if(strcmp(argv[i],"-c")==0)
			{
				if(i==(argc-1))
				{
					fprintf(stderr, "option error!exit!\n");
					return -1;
				}
				com_name = argv[i+1];
			}
			if(strcmp(argv[i],"-r")==0)
			{
				if(i==(argc-2))
				{
					fprintf(stderr, "option error!exit!\n");
					return -1;
				}
				filename = argv[i+1];
				mode = 1;
				sscanf(argv[i+2],"%x",&addr);
			}
			else if(strcmp(argv[i],"-f")==0)
			{
				if(i==(argc-2))
				{
					fprintf(stderr, "option error!exit!\n");
					return -1;
				}
				filename = argv[i+1];
				mode = 0;				
				for(int j=0;j<4;j++)
					sscanf(argv[i+2],"%x",&addr);
			}
			else if(strcmp(argv[i],"-k")==0)
			{		
				flagx = 0;		
				mode = 4;
				for(int k=0;k<argc;k++)
				{
					if(strcmp(argv[k],"-s")==0)
					{												
						mode = 3;
						break;
					}					
				}								
				if(i==(argc-2))
				{					
					fprintf(stderr, "option error!exit!\n");
					return -1;	
				}
				for(int j=0;j<4;j++)
					sscanf(argv[i+1],"%x",&addr);
				for(int j=0;j<4;j++)
					sscanf(argv[i+2],"%x",&f_addr);
				if(i==(argc-3))
				{
					fprintf(stderr, "option error!exit!\n");
					return -1;						
				}
				if(strcmp(argv[i+3],"-s")!=0)
					filename = argv[i+3];
			}
		}
	}
	if(flag)
	{
		if(com_name ==NULL)
			com_name = (char*)"COM1";
		if(filename==NULL && flagx)
			filename = (char*)"kernel.dat";		
		FlashAndRam(com_name,filename,addr,f_addr,mode);
	}
    return 0;
}

