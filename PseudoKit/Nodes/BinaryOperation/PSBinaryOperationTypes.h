//
//  PSBinaryOperationTypes.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

typedef NS_ENUM(NSInteger, PSBinaryOperationTypes) {
    PSBinaryOperationTypesEqual,
    PSBinaryOperationTypesUnequal,
    PSBinaryOperationTypesGreaterThan,
    PSBinaryOperationTypesGreaterThanOrEqual,
    PSBinaryOperationTypesLessThan,
    PSBinaryOperationTypesLessThanOrEqual,
    PSBinaryOperationTypesAddition,
    PSBinaryOperationTypesSubtraction,
    PSBinaryOperationTypesMultiplication,
    PSBinaryOperationTypesDivision,
    PSBinaryOperationTypesIntegerDivision,
    PSBinaryOperationTypesModulo
};
