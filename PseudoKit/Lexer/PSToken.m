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
