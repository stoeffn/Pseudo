//
//  PSLiteralNode+Types.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSLiteralNode+Types.h"

@implementation PSLiteralNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSLiteralTypes) type {
    switch (type) {
        case PSLiteralTypesNull:    return @"NULL";
        case PSLiteralTypesTrue:    return @"TRUE";
        case PSLiteralTypesFalse:   return @"FALSE";
        case PSLiteralTypesNumber:  return @"NUMBER";
        case PSLiteralTypesString:  return @"STRING";
    }
}

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType {
    switch (tokenType) {
        case PSTokenTypesNull:      return @(PSLiteralTypesNull);
        case PSTokenTypesTrue:      return @(PSLiteralTypesTrue);
        case PSTokenTypesFalse:     return @(PSLiteralTypesFalse);
        case PSTokenTypesNumber:    return @(PSLiteralTypesNumber);
        case PSTokenTypesString:    return @(PSLiteralTypesString);
        default:                    return NULL;
    }
}

@end
