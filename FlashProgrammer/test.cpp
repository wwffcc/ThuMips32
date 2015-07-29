#include <stdio.h>

int main()
{
	unsigned int a[]={0x00021880,0x00621023,0x218f0020,0x06006210};
	FILE* fp = fopen("test2.dat","wb");
	fwrite((void*)a,sizeof(unsigned int),sizeof(a)/sizeof(unsigned int),fp);
	fclose(fp);
	return 0;
}
