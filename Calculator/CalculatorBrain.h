//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Eduardo Montero on 12/08/12.
//  Copyright (c) 2012 Eduardo Montero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperand:(NSString *)operation;
- (void)cleanAll;
@end
