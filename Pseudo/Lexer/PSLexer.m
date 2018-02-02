//
//  PSLexer.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "PSLexer.h"
#import "PSToken.h"

@implementation PSLexer

- (instancetype) initWithCode: (NSString *) code {
    if (self = [super init]) {
        _code = code;
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Code: '%@', Tokens: %@>",
            NSStringFromClass([self class]), self.code, self.tokens];
}

- (NSArray<PSToken *> *) tokens {
    NSMutableArray *tokens = [[NSMutableArray alloc] init];
    NSMutableString *currentRawToken = [[NSMutableString alloc] init];

    // TODO: Use a char buffer for better performance.
    // TODO: Replace with generator instead of returning an array.
    for (NSInteger index = 0; index < self.code.length; index++) {
        unichar character = [self.code characterAtIndex: index];

        if ([PSLexer.delimitingCharacters characterIsMember: character]) {
            PSToken *token = [[PSToken alloc] initWithRawToken: currentRawToken];
            if (token != NULL) {
                [tokens enqueue: token];
            }

            currentRawToken = [[NSMutableString alloc] init];
        }

        [currentRawToken appendFormat: @"%C", character];
    }

    PSToken *token = [[PSToken alloc] initWithRawToken: currentRawToken];

    if (token != NULL) {
        [tokens addObject: token];
    }

    return tokens;
}

+ (NSCharacterSet *) delimitingCharacters {
    static NSMutableCharacterSet *_delimitingCharacters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _delimitingCharacters = NSMutableCharacterSet.whitespaceAndNewlineCharacterSet;
        [_delimitingCharacters addCharactersInString: @"(){}:."];
    });
    return _delimitingCharacters;
}

@end
