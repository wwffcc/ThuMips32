#include <stdio.h>
#include <string.h>
#include "translator.h"

int main(int argc,char** argv)
{
	if(argc<3)
	{
		fprintf(stderr, "format error\n");
		fprintf(stderr, "%s filename -p|-d\n",argv[0]);
	}
	Translator tran;
	if(strcmp(argv[2],"-p")==0)		
		tran.parse(argv[1]);	
	else if(strcmp(argv[2],"-d")==0)
		tran.disas(argv[1]);
	return 0;
}
