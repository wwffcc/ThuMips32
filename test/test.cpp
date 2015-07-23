#include <stdio.h>

int main()
{
	FILE* fp = fopen("test1.dat","wb");
	unsigned int code[]={	\
				0x24081234,0x24097000,0x01094821,0x0128502a,\
				0x29023005,0x2d033005,0x0128202b,0x01282823,\
				0x01093024,0x31071023,0x3c0a1234,0x000a58c0\
	};
	fwrite((void*)code,sizeof(unsigned int),12,fp);
	fclose(fp);
	return 0;
}
