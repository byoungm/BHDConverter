//
//  Conversion.m
//  HexDecBin
//
//  Created by Benjamin Young on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Conversion.h"

@implementation Conversion

 + (NSString *)hexFromDecimal:(NSString *)decimal
 {
     if (!decimal || [decimal isEqualToString:@""]) return decimal;
     
     char * answer_c_str = malloc([decimal length]);
     long long decimal_num = [decimal longLongValue];
     long ans_cnt = 0;
     long rem = 0;
     
     
     while (true){
         rem = decimal_num % 16;
         decimal_num /= 16;
         switch(rem){
             case 10:
                     answer_c_str[ans_cnt++] = 'A';
             break;
             case 11:
                     answer_c_str[ans_cnt++] = 'B';
             break;
             case 12:
                     answer_c_str[ans_cnt++] = 'C';
             break;
             case 13:
                     answer_c_str[ans_cnt++] = 'D';
             break;
             case 14:
                     answer_c_str[ans_cnt++] = 'E';
             break;
             case 15:
                     answer_c_str[ans_cnt++] = 'F';
             break;
             default:
                    answer_c_str[ans_cnt++] = rem + '0';
             break;
         }
         if (decimal_num <= 0) break; //break from while loop
     }
     answer_c_str[ans_cnt++]='\0';
     reverse_c_str(answer_c_str);
     
     return [NSString stringWithCString:answer_c_str encoding:NSASCIIStringEncoding];
 }



+ (NSString *)hexFromBinary:(NSString *)binary
{
    if (!binary || [binary isEqualToString:@""]) return binary;
    
    const char * binary_c_str = [binary cStringUsingEncoding:NSASCIIStringEncoding];
    long sub_cnt = 0;
    long bin_cnt = strlen(binary_c_str);
	long ans_cnt = bin_cnt/4 + 1 + ( (bin_cnt % 4 != 0) ? 1 : 0 ); // bin_cnt / 4 + 1 + (1 if remainder for div by 4)
	char c = '\0';
	char * substr = malloc(sizeof(char) * 5);
    char * answer_c_str = malloc(sizeof(char) * ans_cnt);
    
	//nullify end of strings
	substr[4] = '\0';
	answer_c_str[--ans_cnt] = '\0';
    
    while ( bin_cnt >= 0 ) {
        
		//create sub string of 4 characters
        for(sub_cnt=3; sub_cnt>-1; sub_cnt--){
			bin_cnt--;
			substr[sub_cnt] = (bin_cnt >= 0) ? binary_c_str[bin_cnt] : '0';
		}
        
        switch (atoi(substr)) {
            case    0: c = '0'; break;
            case    1: c = '1'; break;
            case   10: c = '2'; break;
            case   11: c = '3'; break;
            case  100: c = '4'; break;
            case  101: c = '5'; break;
            case  110: c = '6'; break;
            case  111: c = '7'; break;
            case 1000: c = '8'; break;
            case 1001: c = '9'; break;
            case 1010: c = 'A'; break;
            case 1011: c = 'B'; break;
            case 1100: c = 'C'; break;
            case 1101: c = 'D'; break;
            case 1110: c = 'E'; break;
            case 1111: c = 'F'; break;
            default: c = '?'; break;
        }
        answer_c_str[--ans_cnt] = c;
    }
	//free memory
	free(substr);
    
    return [NSString stringWithCString:answer_c_str encoding:NSASCIIStringEncoding];
}


+ (NSString *)binaryFromDecimal:(NSString *)decimal
{
    if (!decimal || [decimal isEqualToString:@""] || [decimal isEqualToString:@"0"]) return decimal;
    
    long long decimal_num = decimal.longLongValue;
    long double nbits = log( decimal_num * 1.0 ) / log( 2.0 );  //number of bits based on 2^n = decimal
    long ans_cnt = ( long )( floorl( nbits ) + 2 );   //+1 for extra bit after floor, +1 for null char.
    char * answer_c_str = malloc( ans_cnt );
	long remainder =0;
    
	answer_c_str[--ans_cnt] = '\0';  //add null character to end of string
    
	while ( decimal_num > 0 ) {
		remainder = decimal_num % 2;
		decimal_num /= 2;
		answer_c_str[--ans_cnt] = remainder ? '1' : '0';
	}
    
    return [NSString stringWithCString:answer_c_str encoding:NSASCIIStringEncoding];
}


+ (NSString *)binaryFromHex:(NSString *)hex
{
    if (!hex || [hex isEqualToString:@""]) return hex;
    
    NSMutableString *finalAnswer;
    const char * hex_c_str = [hex cStringUsingEncoding:NSASCIIStringEncoding];
    char * sub_str = "0000";
	char * answer_c_str = malloc(strlen(hex_c_str) * 4 + 1); //+1 for null char
	const long hex_str_len = strlen(hex_c_str);
	long sub_cnt = 0;
	long hex_num = 0;
	long hex_cnt = 0;
	long ans_cnt = 0;
    
	for (hex_cnt = 0 ; hex_cnt < hex_str_len ; hex_cnt++){
        
        hex_num = ( hex_c_str[hex_cnt] - '0' < 10 ) ? hex_c_str[hex_cnt] - '0' : hex_c_str[hex_cnt] - '0' - 7; //7 characters in between A and 9
		switch (hex_num) {
            case  0: sub_str = "0000"; break;
            case  1: sub_str = "0001"; break;
            case  2: sub_str = "0010"; break;
            case  3: sub_str = "0011"; break;
            case  4: sub_str = "0100"; break;
            case  5: sub_str = "0101"; break;
            case  6: sub_str = "0110"; break;
            case  7: sub_str = "0111"; break;
            case  8: sub_str = "1000"; break;
            case  9: sub_str = "1001"; break;
            case 10: sub_str = "1010"; break;
            case 11: sub_str = "1011"; break;
            case 12: sub_str = "1100"; break;
            case 13: sub_str = "1101"; break;
            case 14: sub_str = "1110"; break;
            case 15: sub_str = "1111"; break;
            default: sub_str = "????"; break;
		}
        
        //create sub string of 4 characters
        for(sub_cnt=0; sub_cnt < 4; sub_cnt++){
			answer_c_str[ans_cnt++] = sub_str[sub_cnt];
		}
	}
    answer_c_str[ans_cnt] = '\0';
    
    //remove possible 3 leading zeros.  If 0 delete first character
    finalAnswer = [NSMutableString stringWithCString:answer_c_str encoding:NSASCIIStringEncoding];
    while ([finalAnswer length] > 1) {
        if ( [finalAnswer characterAtIndex:0] == '0' ) [finalAnswer deleteCharactersInRange:NSMakeRange(0, 1)];
        else break;
    }
    
    return finalAnswer;
}


 + (NSString *)decimalFromHex:(NSString *)hex
 {
     if (!hex || [hex isEqualToString:@""]) return hex;
     
     const char * hex_c_str = [hex cStringUsingEncoding:NSASCIIStringEncoding];
     long hex_str_len = strlen(hex_c_str);
     long i = 0;
     long double decimal = 0;
     char num = 0;
     
     for(i=0; hex_str_len > 0; i++, hex_str_len--){
     
         if('0' <= hex_c_str[i] && hex_c_str[i] <= '9') num = hex_c_str[i] - '0';
         if('A' <= hex_c_str[i] && hex_c_str[i] <= 'F') num = hex_c_str[i] - 55;
         
         decimal += num * pow(16.0, hex_str_len-1);
     }
     
     return [NSString stringWithFormat:@"%.0Lf",decimal];
 }


+ (NSString *)decimalFromBinary:(NSString *)binary
{
    if (!binary || [binary isEqualToString:@""]) return binary;
    
    const char *binary_c_str = [binary cStringUsingEncoding:NSASCIIStringEncoding];
    long long count = [binary length] - 1;
    long long decimal = 0;
    long long two_pow_n = 1;
    
    while (count > -1) {
        decimal += (binary_c_str[count--] - '0') * two_pow_n;
        two_pow_n *= 2;
    }
    return [NSString stringWithFormat:@"%lld",decimal];
}

#pragma utility

void reverse_c_str(char * str)
{
    if (str) {
        char * end = str + strlen(str) - 1;
        
        // swap the values in the two given variables
        // XXX: fails when a and b refer to same memory location
        #define XOR_SWAP(a,b) { a ^= b; b ^= a; a ^= b; }
        
        // walk inwards from both ends of the string,
        // swapping until we get to the middle
        while (str < end) {
            XOR_SWAP(*str, *end);
            str++;
            end--;
        }
    }
}


@end
