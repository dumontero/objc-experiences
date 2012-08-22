//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Eduardo Montero on 12/08/12.
//  Copyright (c) 2012 Eduardo Montero. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack{
    if (!_operandStack){
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}


- (void)pushOperand:(double)operand{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperand:(NSString *)operation;{
    
    double result = 0;
    
    if ([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]){
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]){
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"π"]){
        result = 3.141592653589793;
    } else if ([operation isEqualToString:@"sin"]){
        result = sin(([self popOperand] * 3.141592653589793) / 180);
    } else if ([operation isEqualToString:@"cos"]){
        result = cos(([self popOperand] * 3.141592653589793) / 180);
    } else if ([operation isEqualToString:@"√"]){
        result = sqrt([self popOperand]);
    }
    
    [self pushOperand:result];
    
    return result;
}

- (void)cleanAll{
    [self.operandStack removeAllObjects];
}

@end
