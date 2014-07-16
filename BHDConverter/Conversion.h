//
//  Conversion.h
//  HexDecBin
//
//  Created by Benjamin Young on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conversion : NSObject

+ (NSString *)hexFromDecimal:(NSString *)decimal;
+ (NSString *)hexFromBinary:(NSString *)binary;

+ (NSString *)binaryFromDecimal:(NSString *)decimal;
+ (NSString *)binaryFromHex:(NSString *)hex;

+ (NSString *)decimalFromHex:(NSString *)hex;
+ (NSString *)decimalFromBinary:(NSString *)binary;

@end
