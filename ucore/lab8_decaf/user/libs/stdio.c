#include <defs.h>
#include <stdio.h>
#include <syscall.h>
#include <file.h>
#include <ulib.h>
#include <unistd.h>


#define printf(...)                     fprintf(1, __VA_ARGS__)
#define putc(c)                         printf("%c", c)

#define BUFSIZE                         4096

/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
    sys_putc(c);
    (*cnt) ++;
}

/* *
 * vcprintf - format a string and writes it to stdout
 *
 * The return value is the number of characters which would be
 * written to stdout.
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
    int cnt = 0;
    vprintfmt((void*)cputch, NO_FD, &cnt, fmt, ap);
    return cnt;
}

/* *
 * cprintf - formats a string and writes it to stdout
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}

/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}


static void
fputch(char c, int *cnt, int fd) {
    write(fd, &c, sizeof(char));
    (*cnt) ++;
}

int
vfprintf(int fd, const char *fmt, va_list ap) {
    int cnt = 0;
    vprintfmt((void*)fputch, fd, &cnt, fmt, ap);
    return cnt;
}

int
fprintf(int fd, const char *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);
    int cnt = vfprintf(fd, fmt, ap);
    va_end(ap);

    return cnt;
}

char *
readline(const char *prompt) {
    static char buffer[BUFSIZE];
    memset(buffer,0,BUFSIZE);
    if (prompt != NULL) {
        printf("%s", prompt);
    }
    int ret, i = 0;
    while (1) {
        char c;
        if ((ret = read(0, &c, sizeof(char))) < 0) {
            return NULL;
        }
        else if (ret == 0) {
            if (i > 0) {
                buffer[i] = '\0';
                break;
            }
            return NULL;
        }

        if (c == 3) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
            putc(c);
            buffer[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
            putc(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
            putc(c);
            buffer[i] = '\0';
            break;
        }
    }
    return buffer;
}
