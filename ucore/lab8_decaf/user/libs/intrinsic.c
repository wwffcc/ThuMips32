#include <defs.h>
#include <stdio.h>
#include <ulib.h>

static char buf[4096];

static char bufx[4096];

void* _Alloc(int n) {
    static char* cur = buf;
    char* p;
    if((cur+n)>=(buf+4096)){
        cur = buf;
        p = buf;
    }
    else{
        p = cur;
        cur += n;
    }
    return p;
}

void* stralloc(int n){
    static char* cur = bufx;
    char* p;
    if((cur+n)>=(bufx+4096)){
        cur = bufx;
        p = bufx;
    }
    else{
        p = cur;
        cur += n;
    }
    return p;
}

void _PrintInt(int x) {
    cprintf("%d", x);
}
void _PrintChar(char x) {
    cprintf("%c", x);
}
void _PrintString(const char* x) {
    cprintf("%s", x);
}
void _PrintBool(bool x) {
    if (x)
        cprintf("true");
    else
        cprintf("false");
}
void __noreturn _Halt(void) {
    exit(0);
}
char* _ReadLine(void){
    char* r = readline(NULL);
    int n = strlen(r);
    char* a = stralloc(n+1);
    
    memcpy(a,r,n);
    a[n]='\0';
    return a;
}

int _StringEqual(char* a,char* b){
	if(strcmp(a,b)==0)
		return 1;
	else
		return 0;
}

int _ReadInteger(void){
	char* str = readline(NULL);
	return strtol(str,NULL,10);
}

