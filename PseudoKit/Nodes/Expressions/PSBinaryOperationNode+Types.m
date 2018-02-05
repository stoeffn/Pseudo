//
//  PSBinaryOperationNode+Types.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSBinaryOperationNode+Types.h"

@implementation PSBinaryOperationNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSBinaryOperationTypes) type {
    switch (type) {
        case PSBinaryOperationTypesAddtion:         return @"ADDTITION";
        case PSBinaryOperationTypesSubtraction:     return @"SUBSTRACTION";
        case PSBinaryOperationTypesMultiplication:  return @"MULTIPLICATION";
        case PSBinaryOperationTypesDivision:        return @"DIVISION";
        case PSBinaryOperationTypesIntegerDivision: return @"INTEGER_DIVISION";
        case PSBinaryOperationTypesModulo:          return @"MODULO";
    }
}

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType {
    switch (tokenType) {
        case PSTokenTypesPlus:
            return @(PSBinaryOperationTypesAddtion);
        case PSTokenTypesMinus:
            return @(PSBinaryOperationTypesSubtraction);
        case PSTokenTypesTimes:
            return @(PSBinaryOperationTypesMultiplication);
        case PSTokenTypesDividedBy:
            return @(PSBinaryOperationTypesDivision);
        case PSTokenTypesDividedAsIntegerBy:
            return @(PSBinaryOperationTypesIntegerDivision);
        case PSTokenTypesModulo:
            return @(PSBinaryOperationTypesModulo);
        default:
            return NULL;
    }
}

@end
