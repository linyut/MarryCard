#include "utility.h"

int digit(char c) //char 以16进制转Int
{
	switch (c) {
	case '0':
		return 0;
		break;
	case '1':
		return 1;
		break;
	case '2':
		return 2;
		break;
	case '3':
		return 3;
		break;
	case '4':
		return 4;
		break;
	case '5':
		return 5;
		break;
	case '6':
		return 6;
		break;
	case '7':
		return 7;
		break;
	case '8':
		return 8;
		break;
	case '9':
		return 9;
		break;
	case 'a':
		return 10;
		break;
	case 'b':
		return 11;
		break;
	case 'c':
		return 12;
		break;
	case 'd':
		return 13;
		break;
	case 'e':
		return 14;
		break;
	case 'f':
		return 15;
		break;
	default:
		return -1;
		break;
	}
}
char * int2binarayString(int x) {
	static char binaryString[intLength];
	int i = 0;
	for (i = 0; i < intLength; i++) {
		*(binaryString + intLength - 1 - i) =
				((x >> i) & 0x00000001) > 0 ? '1' : '0';
	}
	return binaryString;
}

long long binaryString2int(char *bs) {
	long long result = 0;
	int i = 0;
	for (i = 0; i < intLength; i++) {
		if (*(bs + i) == '1')
			result += (long long) pow(2, intLength - 1 - i);
	}
	return result;
}

int bytes2int(bytes b) //4 个 byte 转成 int
{
	int mask = 0xff;
	int temp = 0;
	int n = 0;
	int i = 0;
	for (i = 0; i < 4; i++) {

		temp = *(b.p + i) & mask;
		n |= temp;
		n <<= 8;
	}
	return n;
}
bytes hexString2ByteArray(char *hexString) {
	int len = (int)strlen(hexString);
	int i = 0;
	bytes data = { .length = len / 2, .p = (byte *) malloc(
			sizeof(byte) * len / 2) };
	for (i = 0; i < len; i += 2) {
		*(data.p + i / 2) = (byte) (((digit(*(hexString + i))) << 4)
				+ digit(*(hexString + i + 1)));
	}
	return data;

}
bytes int2bytes(int x) {
	bytes buf = { .length = 4, .p = (byte *) malloc(4 * sizeof(byte)) };
	//char c = (byte)(x >> 24 & 0xff);
	*(buf.p) = (byte) (x >> 24 & 0xff);
	*(buf.p + 1) = (byte) (x >> 16 & 0xff);
	*(buf.p + 2) = (byte) (x >> 8 & 0xff);
	*(buf.p + 3) = (byte) (x & 0xff);
	return buf;
}
bytes long2bytes(long long x) {
	bytes buf = { .length = 8, .p = (byte *) malloc(8 * sizeof(byte)) };
	int i = 0;
	for (i = 0; i < 8; i++) {
		int offset = (buf.length - 1 - i) * 8;
		*(buf.p + i) = (byte) (x >> offset & 0xff);
	}
	return buf;
}
bytes string2bytesByAscii(char *s) {
	int sLen = (int)strlen(s);
	bytes buf = { .length = sLen, .p = (byte *) malloc(sLen * sizeof(byte)) };
	memcpy(buf.p, s, sLen);
	return buf;
}
bytes sum(bytes x, bytes y) {
	bytes buf = { .length = 0, .p = NULL };
	if (x.length + y.length > 0) {
		buf.length = x.length + y.length;
		buf.p = (byte *) malloc((x.length + y.length) * sizeof(byte));
	}
	if (x.length > 0) {
		memcpy(buf.p, x.p, x.length);
	}
	if (y.length > 0) {
		memcpy(buf.p + x.length, y.p, y.length);
	}
	return buf;
}
char *addZeroForNum(char *num, int length) {
	char *resultStr = (char *) malloc((length + 1) * sizeof(char));
	memset(resultStr, '0', length - strlen(num));
	strcpy(resultStr + length - strlen(num), num);
	free(num);
	return resultStr;
}

void *my_memcpy(void *dest, const void *src, long count) {
//	ASSERT((dest != NULL)&&(src != NULL));  
	unsigned char *temp_dest = (unsigned char *) dest;
	unsigned char *temp_src = (unsigned char *) src;
	while (count--)  // 不对是否存在重叠区域进行判断
	{
		*temp_dest++ = *temp_src++;
	}
	return dest;
}
unsigned char *my_memset(unsigned char *dst, unsigned char value,
		long count) {
	unsigned char *start = dst;
	while (count--)
		*dst++ = value;
	return (start);
}

/* utility function to convert hex character representation to their nibble (4 bit) values */
static char nibbleFromChar(char c) {
	if (c >= '0' && c <= '9')
		return c - '0';
	if (c >= 'a' && c <= 'f')
		return c - 'a' + 10;
	if (c >= 'A' && c <= 'F')
		return c - 'A' + 10;
	return 255;
}

/* Convert a string of characters representing a hex buffer into a series of bytes of that real value
 * "9F060842"--->[0x9F,0x06,0x08,0x42]
 * */
char* hexStringToBytes(char *inhex, int inhexLen) {
	int len = inhexLen / 2;
	char* retval = (char*) malloc(len + 1);
	memset(retval, 0, len + 1);

	int i;
	char *p;
	for (i = 0, p = (char *) inhex; i < len; i++, p += 2) {
		retval[i] = (nibbleFromChar(*p) << 4) | nibbleFromChar(*(p + 1));
	}
	return retval;
}

static char byteMap[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a',
		'b', 'c', 'd', 'e', 'f' };
static int byteMapLen = sizeof(byteMap);

/* Utility function to convert nibbles (4 bit values) into a hex character representation */
static char nibbleToChar(char nibble) {
	if ((int)nibble < byteMapLen)
		return byteMap[(int)nibble];
	return '*';
}

/* Convert a buffer of binary values into a hex string representation
 * [0x9F,0x06,0x08,0x42]--->"9F060842"
 * */
char* bytesToHexString(unsigned char *bytes, int buflen) {
	char *retval;
	int i;

	retval = (char*) malloc(buflen * 2 + 1);
	memset(retval, 0, buflen * 2 + 1);

	for (i = 0; i < buflen; i++) {
		retval[i * 2] = nibbleToChar(bytes[i] >> 4);
		retval[i * 2 + 1] = nibbleToChar(bytes[i] & 0x0f);
	}
	return retval;
}

/**
 * "9F02"--->"39463032"
 */
char* str2AsciiStr(char* str, int len) {

	char* asciiStr = (char*) malloc(len * 2 + 1);
	int i = 0;
	memset(asciiStr, 0, len * 2 + 1);
	if (NULL == asciiStr)
		return NULL;

	for (i = 0; i < len; i++) {
		sprintf(asciiStr + i * 2, "%02X", *(str + i));
	}
	return asciiStr;
}

/**
 *从第n个字符开始删掉m个字符 
 */ 
void strdel(unsigned char *src, unsigned char *des, int n, int m)
{
    int i = 0;
    int j = 0;

    for(; *(src + i) != '\0'; i++)
    {
        if(i < n - 1 || i > n + m - 2)
        {
            *(des + j++) = *(src + i);
        }
    }

    *(des + j) = '\0';
}

