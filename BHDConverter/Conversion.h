//
//  Conversion.h
//  HexDecBin
//
//  Created by Benjamin Young on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conversion : NSObject{
    NSString *     hexNumber;
    double         binaryNumber;
    double         decimalNumber;
    
}
@property (nonatomic, retain) NSString * hexNumber;

- (id) initWithBinary: (double) aBinaryNumber andWithDecimal: (int) aDecimalNumber andWithHex: (NSString*) aHexNumber;

- (int)    hextoDecimal;
- (double) binaryToDecimal;
- (int) decimalToBinary;

@end
