//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Eduardo Montero on 12/08/12.
//  Copyright (c) 2012 Eduardo Montero. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL usuarioEstaNoMeioDaDigitacaoNumerica;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL jaUsouDecimal;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize historico = _historico;
@synthesize usuarioEstaNoMeioDaDigitacaoNumerica = _usuarioEstaNoMeioDaDigitacaoNumerica;
@synthesize brain = _brain;
@synthesize jaUsouDecimal = _jaUsouDecimal;

- (CalculatorBrain *)brain{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = sender.currentTitle; // [sender currentTitle];
    
    if (self.usuarioEstaNoMeioDaDigitacaoNumerica) {
        if (([digit isEqualToString:@"."] && !self.jaUsouDecimal) || ![digit isEqualToString:@"."]) {
            self.display.text = [self.display.text stringByAppendingString:digit];
            if ([digit isEqualToString:@"."]) {
                self.jaUsouDecimal = YES;
            }
        }
    } else {
        if ([digit isEqualToString:@"."]){
            self.display.text = @"0.";
            self.jaUsouDecimal = YES;
        } else {
            self.display.text = digit;
        }
        self.usuarioEstaNoMeioDaDigitacaoNumerica = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.usuarioEstaNoMeioDaDigitacaoNumerica = NO;
    self.jaUsouDecimal = NO;
    self.historico.text = [[self.historico.text stringByReplacingOccurrencesOfString:@" ="
                                                                          withString:@""] stringByAppendingString:[@" " stringByAppendingString:self.display.text]];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.usuarioEstaNoMeioDaDigitacaoNumerica) [self enterPressed];
    
    NSString *operation = sender.currentTitle;
    double result = [self.brain performOperand:operation];
    self.historico.text = [[self.historico.text stringByReplacingOccurrencesOfString:@" ="
                                                                           withString:@""] stringByAppendingString:[@" " stringByAppendingString:[operation stringByAppendingString:@" ="]]];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)cleanPressed {
    [self.brain cleanAll];
    self.usuarioEstaNoMeioDaDigitacaoNumerica = NO;
    self.jaUsouDecimal = NO;
    self.display.text = @"0";
    self.historico.text = @"";
}

- (IBAction)backspacePressed {
    if ([self.display.text length] > 0)
    self.display.text = [self.display.text substringToIndex:([self.display.text length]-1)];
}

- (IBAction)plusMinusPressed:(UIButton *)sender {
    if (![self.display.text isEqualToString:@"0"]) {
        if ([self.display.text hasPrefix:@"-"]) {
            if ([self.display.text length] > 1) {
                self.display.text = [self.display.text substringFromIndex:1];
            } else {
                self.display.text = @"0";
            }
        } else {
            self.display.text = [@"-" stringByAppendingString:self.display.text];
        }
    }
}
@end
