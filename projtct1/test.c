//test.c
#include <stdio.h>
#include <time.h>
char *gets(char *input) {
    char *ret = input;
    int cnt;
    while ((cnt = getchar()) != '\n' && cnt != EOF) {
        *ret++ = cnt;
        if (cnt == EOF && ret == input) {
            return NULL;
        }
    }
    *ret++ = '\0';
    return ret;
}
void test() {
    char input[1];
    gets(input);
    puts(input);
}
int main() {
    test();
    return 0;
}