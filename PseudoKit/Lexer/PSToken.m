//
//  PSToken.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSToken.h"

@implementation PSToken

#pragma mark - Life Cycle

- (instancetype) initWithType: (PSTokenType) type andValue: (NSString *) value {
    if (self = [super init]) {
        _type = type;
        _value = value;
    }
    return self;
}

- (instancetype) initWithRawToken: (NSString *) rawToken {
    NSString *trimmedRawToken = [rawToken stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceAndNewlineCharacterSet];

    if (trimmedRawToken.length == 0) {
        return NULL;
    }

    NSNumber *delimiter = PSToken.delimiters[trimmedRawToken];
    if (delimiter != NULL) {
        return [self initWithType: delimiter.integerValue andValue: NULL];
    }

    NSNumber *keyword = PSToken.keywords[[trimmedRawToken uppercaseString]];
    if (keyword != NULL) {
        return [self initWithType: keyword.integerValue andValue: NULL];
    }

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString: trimmedRawToken];
    if (number != NULL) {
        return [self initWithType: PSTokenTypeNumberLiteral andValue: trimmedRawToken];
    }

    return [self initWithType: PSTokenTypeIdentifier andValue: trimmedRawToken];
}

#pragma mark - Description

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Type: %ld, Value: '%@'>",
            NSStringFromClass([self class]), (long) self.type, self.value];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return self == object
        || ([object isKindOfClass: [PSToken class]] && [self isEqualToToken: (PSToken *) object]);
}

- (BOOL) isEqualToToken: (PSToken *) token {
    return token
        && self.type == token.type
        && ((!self.value && !token.value) || [self.value isEqualToString: token.value]);
}

- (NSUInteger) hash {
    return (self.type + 17) ^ self.value.hash;
}

#pragma mark - Constants

+ (NSDictionary<NSString *, NSNumber *> *) keywords {
    static NSDictionary *_keywords;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keywords = @{@"ALGORITHM": [NSNumber numberWithInt: PSTokenTypeAlgorithm],
                      @"RETURN": [NSNumber numberWithInt: PSTokenTypeReturn]};
    });
    return _keywords;
}

+ (NSDictionary<NSString *, NSNumber *> *) delimiters {
    static NSDictionary *_delimiters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _delimiters = @{@"(": [NSNumber numberWithInt: PSTokenTypeOpeningParenthesis],
                        @")": [NSNumber numberWithInt: PSTokenTypeClosingParenthesis],
                        @"{": [NSNumber numberWithInt: PSTokenTypeOpeningBrace],
                        @"}": [NSNumber numberWithInt: PSTokenTypeClosingBrace],
                        @":": [NSNumber numberWithInt: PSTokenTypeColon],
                        @".": [NSNumber numberWithInt: PSTokenTypePoint]};
    });
    return _delimiters;
}

@end
