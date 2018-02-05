//
//  PSUnaryOperationNode+Types.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSUnaryOperationNode+Types.h"

@implementation PSUnaryOperationNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSUnaryOperationTypes) type {
    switch (type) {
        case PSUnaryOperationTypesNot:      return @"NOT";
        case PSUnaryOperationTypesNegation: return @"NEGATION";
    }
}

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType {
    switch (tokenType) {
        case PSTokenTypesNot:   return @(PSUnaryOperationTypesNot);
        case PSTokenTypesMinus: return @(PSUnaryOperationTypesNegation);
        default:                return NULL;
    }
}

@end
