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

@interface PSLexer ()

@property (nonatomic) NSUInteger currentCharacterIndex;

@end

@implementation PSLexer

#pragma mark - Life Cycle

- (instancetype) initWithCode: (NSString *) code {
    if (self = [super init]) {
        _code = code;
        _currentCharacterIndex = 0;
    }
    return self;
}

#pragma mark - Description

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Code: '%@'>",
            NSStringFromClass([self class]), self.code];
}

#pragma mark - Generating Tokens

- (PSToken *) nextToken {
    if (self.currentCharacterIndex >= self.code.length) return NULL;

    __block BOOL wasLastCharDelimiting = NO;
    __block NSRange rawTokenRange = NSMakeRange(self.currentCharacterIndex, 0);
    void (^enumerateUntilNextToken)(NSString *, NSRange, NSRange, BOOL *) = ^(NSString *inSubstring,
                                                                              NSRange inSubstringRange,
                                                                              NSRange inEnclosingRange,
                                                                              BOOL *outStop) {
        BOOL isCharDelimiting = [inSubstring rangeOfCharacterFromSet: PSLexer.delimitingCharacters].location != NSNotFound;
        *outStop = rawTokenRange.length > 0 && (isCharDelimiting || (!isCharDelimiting && wasLastCharDelimiting));
        if (*outStop) return;

        rawTokenRange.length += inSubstringRange.length;
        wasLastCharDelimiting = isCharDelimiting;
    };

    NSRange enumerationRange = NSMakeRange(self.currentCharacterIndex, self.code.length - self.currentCharacterIndex);
    [self.code enumerateSubstringsInRange: enumerationRange
                                  options: NSStringEnumerationByComposedCharacterSequences
                               usingBlock: enumerateUntilNextToken];

    self.currentCharacterIndex += rawTokenRange.length;

    NSString *rawToken = [self.code substringWithRange: rawTokenRange];
    PSToken *token = [[PSToken alloc] initWithRawToken: rawToken];

    if (token == NULL) return self.nextToken;
    return token;
}

- (void) reset {
    self.currentCharacterIndex = 0;
}

#pragma mark - Constants

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
