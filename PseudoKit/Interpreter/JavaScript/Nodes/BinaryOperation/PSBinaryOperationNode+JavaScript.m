//
//  PSBinaryOperationNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSBinaryOperationNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSBinaryOperationNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    switch (self.type) {
        case PSBinaryOperationTypesEqual:
            return [[NSString alloc] initWithFormat: @"(%@ == %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesUnequal:
            return [[NSString alloc] initWithFormat: @"(%@ != %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesGreaterThan:
            return [[NSString alloc] initWithFormat: @"(%@ > %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesGreaterThanOrEqual:
            return [[NSString alloc] initWithFormat: @"(%@ >= %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesLessThan:
            return [[NSString alloc] initWithFormat: @"(%@ < %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesLessThanOrEqual:
            return [[NSString alloc] initWithFormat: @"(%@ <= %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesAddition:
            return [[NSString alloc] initWithFormat: @"(%@ + %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesSubtraction:
            return [[NSString alloc] initWithFormat: @"(%@ - %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesMultiplication:
            return [[NSString alloc] initWithFormat: @"(%@ * %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesDivision:
            return [[NSString alloc] initWithFormat: @"(%@ / %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesIntegerDivision:
            return [[NSString alloc] initWithFormat: @"Math.floor(%@ / %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
        case PSBinaryOperationTypesModulo:
            return [[NSString alloc] initWithFormat: @"(%@ %% %@)", self.leftNode.javaScriptCode, self.rightNode.javaScriptCode];
    }
}

@end
