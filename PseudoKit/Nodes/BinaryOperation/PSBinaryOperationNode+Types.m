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
        case PSBinaryOperationTypesEqual:               return @"EQUAL";
        case PSBinaryOperationTypesUnequal:             return @"UNEQUAL";
        case PSBinaryOperationTypesGreaterThan:         return @"GREATER_THAN";
        case PSBinaryOperationTypesGreaterThanOrEqual:  return @"GREATER_THAN_OR_EQUAL";
        case PSBinaryOperationTypesLessThan:            return @"LESS_THAN";
        case PSBinaryOperationTypesLessThanOrEqual:     return @"LESS_THAN_OR_EQUAL";
        case PSBinaryOperationTypesAddition:            return @"ADDITION";
        case PSBinaryOperationTypesSubtraction:         return @"SUBSTRACTION";
        case PSBinaryOperationTypesMultiplication:      return @"MULTIPLICATION";
        case PSBinaryOperationTypesDivision:            return @"DIVISION";
        case PSBinaryOperationTypesIntegerDivision:     return @"INTEGER_DIVISION";
        case PSBinaryOperationTypesModulo:              return @"MODULO";
    }
}

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType {
    switch (tokenType) {
        case PSTokenTypesEquals:                return @(PSBinaryOperationTypesEqual);
        case PSTokenTypesNotEquals:             return @(PSBinaryOperationTypesUnequal);
        case PSTokenTypesGreaterThan:           return @(PSBinaryOperationTypesGreaterThan);
        case PSTokenTypesGreaterThanOrEquals:   return @(PSBinaryOperationTypesGreaterThanOrEqual);
        case PSTokenTypesLessThan:              return @(PSBinaryOperationTypesLessThan);
        case PSTokenTypesLessThanOrEquals:      return @(PSBinaryOperationTypesLessThanOrEqual);
        case PSTokenTypesPlus:                  return @(PSBinaryOperationTypesAddition);
        case PSTokenTypesMinus:                 return @(PSBinaryOperationTypesSubtraction);
        case PSTokenTypesTimes:                 return @(PSBinaryOperationTypesMultiplication);
        case PSTokenTypesDividedBy:             return @(PSBinaryOperationTypesDivision);
        case PSTokenTypesDividedAsIntegerBy:    return @(PSBinaryOperationTypesIntegerDivision);
        case PSTokenTypesModulo:                return @(PSBinaryOperationTypesModulo);
        default:                                return NULL;
    }
}

@end
