//
//  PSToken.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSToken.h"

@implementation PSToken

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

    return [self initWithType: PSTokenTypeIdentifier andValue: trimmedRawToken];
}

- (NSString *) description {
    return [NSString stringWithFormat: @"<PSToken Type: %ld, Value: '%@'>", (long) self.type, self.value];
}

+ (NSDictionary<NSString *, NSNumber *> *) keywords
{
    static NSDictionary *_keywords;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keywords = @{@"ALGORITHM": [NSNumber numberWithInt: PSTokenTypeAlgorithm],
                      @"RETURN": [NSNumber numberWithInt: PSTokenTypeReturn]};
    });
    return _keywords;
}

+ (NSDictionary<NSString *, NSNumber *> *) delimiters
{
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
