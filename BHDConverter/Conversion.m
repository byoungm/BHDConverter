//
//  Conversion.m
//  HexDecBin
//
//  Created by Benjamin Young on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Conversion.h"

@implementation Conversion
@synthesize hexNumber;


- (id) initWithBinary:(double)aBinaryNumber andWithDecimal:(int)aDecimalNumber andWithHex:(NSString *)aHexNumber {
    self = [super init];
    if (self) {
        // Initialization code here.
        hexNumber = aHexNumber;
        binaryNumber = aBinaryNumber;
        decimalNumber = aDecimalNumber;
    }
    
    return self;
}




- (int) hextoDecimal{
    
    unsigned int answer;
    
    NSScanner *scan = [[NSScanner alloc] initWithString:hexNumber];
    
    [scan scanHexInt:&answer];
    return answer;
    
}

- (double) binaryToDecimal{
    
    double answer = 0;
    double binaryInput = binaryNumber;
	double binaryNum = binaryInput + .1;
	double len = 0.0;
	
	while (binaryNum > 1) {
		binaryNum = binaryNum / 10;
		len++;
	}
	
	double multiplier;
	while (len > 0) {
		len--;
		binaryNum = binaryNum *10;
		
		multiplier = floor(binaryNum);
		
		answer = answer + multiplier * pow(2.0, len);
		
		binaryNum = binaryNum - multiplier;
        
    }
    
    
    return answer;
    
}



- (int) decimalToBinary{
    int userInput = decimalNumber;
	
	//variables
	int binaryRemainder = 0;
    int result = 0, mul = 1;  //mul used to advance binary remainder result
	while (userInput > 0) {
		
		binaryRemainder= userInput % 2;
        userInput = userInput / 2;
		
        result = result + binaryRemainder*mul;
        mul *= 10;
	}
	return result;

    
}



@end
