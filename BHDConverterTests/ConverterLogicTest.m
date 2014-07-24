//
//  ConverterLogicTest.m
//  BHDConverter
//
//  Created by Benjamin Young on 7/16/14.
//  Copyright (c) 2014 Benjamin Young. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Conversion.h"

@interface ConverterLogicTest : XCTestCase

@end

@implementation ConverterLogicTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBinaryToDecimalConvertion
{
    for (NSDictionary *dic in [self testArray]) {
        NSString *answer = [Conversion decimalFromBinary:(NSString *)dic[@"binary"]];
        XCTAssertTrue([answer isEqualToString:dic[@"decimal"]], @"Failed to convert %@ to %@; output = %@",dic[@"binary"],dic[@"decimal"], answer);
    }
}

- (void)testBinaryToHexConvertion
{
    for (NSDictionary *dic in [self testArray]) {
        NSString *answer = [Conversion hexFromBinary:(NSString *)dic[@"binary"]];
        XCTAssertTrue([answer isEqualToString:dic[@"hex"]], @"Failed to convert %@ to %@; output = %@",dic[@"binary"],dic[@"hex"], answer);
    }
}

- (void)testDecimalToBinaryConvertion
{
    for (NSDictionary *dic in [self testArray]) {
        NSString *answer = [Conversion binaryFromDecimal:(NSString *)dic[@"decimal"]];
        XCTAssertTrue([answer isEqualToString:dic[@"binary"]], @"Failed to convert %@ to %@; output = %@",dic[@"decimal"],dic[@"binary"], answer);
    }
}

- (void)testDecimalToHex
{
    for (NSDictionary *dic in [self testArray]) {
        NSString *answer = [Conversion hexFromDecimal:(NSString *)dic[@"decimal"]];
        XCTAssertTrue([answer isEqualToString:dic[@"hex"]], @"Failed to convert %@ to %@; output = %@",dic[@"decimal"],dic[@"hex"], answer);
    }
}

- (void)testHexToDecimal
{
    for (NSDictionary *dic in [self testArray]) {
        NSString *answer = [Conversion decimalFromHex:(NSString *)dic[@"hex"]];
        XCTAssertTrue([answer isEqualToString:dic[@"decimal"]], @"Failed to convert %@ to %@; output = %@",dic[@"hex"],dic[@"decimal"], answer);
    }
}

- (void)testHexToBinary
{
    for (NSDictionary *dic in [self testArray]) {
        NSString *answer = [Conversion binaryFromHex:(NSString *)dic[@"hex"]];
        XCTAssertTrue([answer isEqualToString:dic[@"binary"]], @"Failed to convert %@ to %@; output = %@",dic[@"hex"],dic[@"binary"], answer);
    }
}

- (NSArray *)testArray
{
    NSArray *answers = @[@{@"binary": @"101",
                           @"hex" : @"5",
                           @"decimal" : @"5"
                           },
                         @{@"binary": @"1010",
                           @"hex" : @"A",
                           @"decimal" : @"10"
                           },
                         @{@"binary": @"1111",
                           @"hex" : @"F",
                           @"decimal" : @"15"
                           },
                         @{@"binary": @"10001001101111111",
                           @"hex" : @"1137F",
                           @"decimal" : @"70527"
                           },
                         @{@"binary": @"100100011010001010110011110001001101010111100110111101111",
                           @"hex" : @"123456789ABCDEF",
                           @"decimal" : @"81985529216486895"
                           }
                         ];
    
    return answers;
}


@end
