#ifndef UTILITY_h
#define UTILITY_h
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define intLength sizeof(int) * 8
typedef unsigned char byte;

typedef struct {
	int length;
	byte *p;
} bytes;
int digit(char c);
char * int2binarayString(int x);
long long binaryString2int(char *bs);
bytes hexString2ByteArray(char *hexString);
int bytes2int(bytes b);
bytes sum(bytes x, bytes y);
bytes int2bytes(int x);
bytes long2bytes(long long x);
bytes string2bytesByAscii(char *s);
char *addZeroForNum(char *num, int length);
void *my_memcpy(void *dest, const void *src, long count);
unsigned char *my_memset(unsigned char *dst, unsigned char value,
		long count);
		
char* hexStringToBytes(char *inhex, int inhexLen);
char *bytesToHexString(unsigned char *bytes, int buflen);

char* str2AsciiStr(char* str, int len);
void strdel(unsigned char *src, unsigned char *des, int n, int m);

#endif
