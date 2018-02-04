//
//  PSToken.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSToken.h"
#import "PSToken+Types.h"

@implementation PSToken

#pragma mark - Life Cycle

- (nonnull instancetype) initWithType: (PSTokenTypes) type
                               number: (nullable NSNumber *) number {
    if (self = [super init]) {
        _type = type;
        _number = number;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSTokenTypes) type
                               string: (nullable NSString *) string {
    if (self = [super init]) {
        _type = type;
        _string = string;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSTokenTypes) type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (instancetype) initWithRawToken: (NSString *) rawToken {
    /*NSString *trimmedRawToken = [rawToken stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (!rawToken || trimmedRawToken.length == 0) return NULL;

    NSNumber *delimiter = PSToken.delimiters[trimmedRawToken];
    if (delimiter != NULL) return [self initWithType: delimiter.integerValue];

    NSNumber *keyword = PSToken.keywords[[trimmedRawToken uppercaseString]];
    if (keyword != NULL) return [self initWithType: keyword.integerValue];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString: trimmedRawToken];
    if (number != NULL) return [self initWithType: PSTokenTypesNumber number: number];*/

    return [self initWithType: PSTokenTypesIdentifier string: rawToken];
}

#pragma mark - Description

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Type: %@, String: '%@', Number: %@>",
            NSStringFromClass([self class]), [PSToken descriptionForTokenType: self.type], self.string, self.number];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return self == object
        || ([object isKindOfClass: [PSToken class]] && [self isEqualToToken: (PSToken *) object]);
}

- (BOOL) isEqualToToken: (PSToken *) token {
    return token
        && self.type == token.type
        && ((!self.string && !token.string) || [self.string isEqualToString: token.string])
        && ((!self.number && !token.number) || [self.number isEqualToNumber: token.number]);
}

@end
