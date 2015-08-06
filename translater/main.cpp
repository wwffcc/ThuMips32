#include <stdio.h>
#include "translator.h"

int main(int argc,char** argv)
{
	if(argc==1)
	{
		fprintf(stderr, "no filename! exit!\n");
		return -1;
	}
	Translator tran;
	tran.parse(argv[1]);	
		
	return 0;
}
