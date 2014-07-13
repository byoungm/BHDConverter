//
//  BinaryLabel.m
//  HDBConverter
//
//  Created by Benjamin Young on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BinaryLabel.h"

@implementation BinaryLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBinaryText:(NSString *)text
{
    //addspaces for binaryInput's readibility
    NSMutableString *binaryOut = [[text stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    for (int i=binaryOut.length-4; i>0; i=i-4) {
        [binaryOut insertString:@" " atIndex:i];
    }
    [self setText:[binaryOut copy]];
    
}

- (NSString *)binaryText
{
    return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
