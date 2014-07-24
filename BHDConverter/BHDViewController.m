//
//  BHDViewController.m
//  BHDConverter
//
//  Created by Benjamin Young on 7/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "BHDViewController.h"
#import "Conversion.h"
#import "BinaryLabel.h"

#define MAX_BINARY_LENGTH 20

@interface BHDViewController ()
@property (nonatomic, assign) NSUInteger selectedEditingState;
@property (nonatomic, strong) IBOutlet BinaryLabel *binaryInput;
@property (nonatomic, strong) IBOutlet UILabel *hexInput;
@property (nonatomic, strong) IBOutlet UILabel *decimalInput;
@end

@implementation BHDViewController


enum editingState {
    BinaryEditing,
    HexEditing,
    DecimalEditing
};

- (void)setSelectedEditingState:(NSUInteger)selectedEditingState
{
    _selectedEditingState = selectedEditingState;
    [self typeChanged];
}

- (void)typeChanged
{
    NSArray * subs = [[self.view.subviews objectAtIndex:0] subviews];
    for (UIButton * b in subs) {
        if ([b isKindOfClass:[UIButton class]]) {
            switch (self.selectedEditingState) {
                case BinaryEditing:
                    if ([b.titleLabel.text isEqualToString:@"1"] |
                        [b.titleLabel.text isEqualToString:  @"0"] |
                        [b.titleLabel.text isEqualToString:@"<-"] |
                        [b.titleLabel.text isEqualToString:@"DEL"] ) {
                        b.alpha = 1; b.enabled = YES;
                    }else {
                        b.alpha = 0.5; b.enabled = NO;
                    }
                    break;
                case HexEditing:
                    b.alpha = 1; b.enabled = YES;
                    break;
                case DecimalEditing:
                    if ([b.titleLabel.text isEqualToString:@"A"] |
                        [b.titleLabel.text isEqualToString:@"B"] |
                        [b.titleLabel.text isEqualToString:@"C"]|
                        [b.titleLabel.text isEqualToString:@"D"]|
                        [b.titleLabel.text isEqualToString:@"E"]|
                        [b.titleLabel.text isEqualToString:@"F"]) {
                        b.alpha = 0.5; b.enabled = NO;
                    }else {
                        b.alpha = 1; b.enabled = YES;
                    }
                    break;
                default: NSLog(@"Unrecongided state change to editing state: %d",self.selectedEditingState);
            }
        }
    }
}

- (IBAction)buttonPressed:(UIButton *)sender {
    if ( ! [self maxStringLenghExceeded] ) {
        switch (self.selectedEditingState) {
            case BinaryEditing:
                self.binaryInput.binaryText = [self.binaryInput.binaryText stringByAppendingString:sender.titleLabel.text];
                [self binaryEditing];
                break;
            case HexEditing:
                self.hexInput.text = [self.hexInput.text stringByAppendingString:sender.titleLabel.text];
                [self hexEditing];
                break;
            case DecimalEditing:
                self.decimalInput.text = [self.decimalInput.text stringByAppendingString:sender.titleLabel.text];
                [self decimalEditing];
                break;
        }
    }
}

- (IBAction)deletePressed:(UIButton *)sender {
    switch (self.selectedEditingState) {
        case BinaryEditing:
            if(self.binaryInput.binaryText.length > 0) self.binaryInput.binaryText = [self.binaryInput.binaryText substringToIndex:self.binaryInput.binaryText.length - 1];
            [self binaryEditing];
            break;
        case HexEditing:
            if(self.hexInput.text.length > 0) self.hexInput.text = [self.hexInput.text substringToIndex:self.hexInput.text.length - 1];
            [self hexEditing];
            break;
        case DecimalEditing:
            if(self.decimalInput.text.length > 0) self.decimalInput.text = [self.decimalInput.text substringToIndex:self.decimalInput.text.length - 1];
            [self decimalEditing];
            break;
    }
}


#pragma mark - editings

- (void)binaryEditing{
    self.selectedEditingState = BinaryEditing;
    if(self.binaryInput.binaryText.length == 0 || [self.binaryInput.binaryText isEqualToString:@"0"]){
        self.binaryInput.binaryText = @"";
        self.decimalInput.text = @"0";
        self.hexInput.text = @"0";
    }else{
        
        self.decimalInput.text = [Conversion decimalFromBinary:self.binaryInput.binaryText];
        self.hexInput.text = [Conversion hexFromBinary:self.binaryInput.binaryText];
    }
}

- (void)hexEditing{
    self.selectedEditingState = HexEditing;
    if(self.hexInput.text.length == 0 || [self.hexInput.text isEqualToString:@"0"]){
        self.binaryInput.binaryText = @"0";
        self.decimalInput.text = @"0";
        self.hexInput.text = @"";
    }else{

        self.decimalInput.text = [Conversion decimalFromHex:self.hexInput.text];
        self.binaryInput.binaryText = [Conversion binaryFromHex:self.hexInput.text];
    }
}

- (void)decimalEditing{
    self.selectedEditingState = DecimalEditing;
    if(self.decimalInput.text.length == 0 || [self.decimalInput.text isEqualToString:@"0"]){
        self.binaryInput.binaryText = @"0";
        self.decimalInput.text = @"";
        self.hexInput.text = @"0";
    }else{
        
        self.binaryInput.binaryText = [Conversion binaryFromDecimal:self.decimalInput.text];
        self.hexInput.text = [Conversion hexFromDecimal:self.decimalInput.text];
    }
}


#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup editing touches
    [self.binaryInput addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(binaryEditing)]];
    [self.hexInput addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hexEditing)]];
    [self.decimalInput addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(decimalEditing)]];
    
    //sets the initial state
    [self binaryEditing];
    
}

#pragma mark - other

- (BOOL)maxStringLenghExceeded
{
    BOOL stringLengthExceeded = TRUE;
    if (self.binaryInput.binaryText.length < MAX_BINARY_LENGTH) {
        stringLengthExceeded = FALSE;
    }else{
        stringLengthExceeded = TRUE;
        [[[UIAlertView alloc] initWithTitle:@"MAX Length Exceeded" message:nil delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }
    return stringLengthExceeded;
}


@end
