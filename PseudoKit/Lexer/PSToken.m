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

- (nonnull instancetype) initWithType: (PSTokenType) type
                               number: (nullable NSNumber *) number {
    if (self = [super init]) {
        _type = type;
        _number = number;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSTokenType) type
                               string: (nullable NSString *) string {
    if (self = [super init]) {
        _type = type;
        _string = string;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSTokenType) type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (instancetype) initWithRawToken: (NSString *) rawToken {
    NSString *trimmedRawToken = [rawToken stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (!rawToken || trimmedRawToken.length == 0) return NULL;

    NSNumber *delimiter = PSToken.delimiters[trimmedRawToken];
    if (delimiter != NULL) return [self initWithType: delimiter.integerValue];

    NSNumber *keyword = PSToken.keywords[[trimmedRawToken uppercaseString]];
    if (keyword != NULL) return [self initWithType: keyword.integerValue];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString: trimmedRawToken];
    if (number != NULL) return [self initWithType: PSTokenTypeNumberLiteral number: number];

    return [self initWithType: PSTokenTypeIdentifier string: trimmedRawToken];
}

#pragma mark - Description

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Type: %ld, String: '%@', Number: %@>",
            NSStringFromClass([self class]), (long) self.type, self.string, self.number];
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
