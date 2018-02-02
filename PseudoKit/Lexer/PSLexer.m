//
//  PSLexer.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "Constants.h"
#import "NSMutableArray+Queue.h"
#import "PSLexer.h"
#import "PSToken.h"
#import "PSSyntaxNode.h"

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

    if (!token) return self.nextToken;
    return token;
}

#pragma mark - Asserting Tokens

- (PSToken *) expectTokenType: (PSTokenType) tokenType
                        error: (NSError **) error {
    if (*error) return NULL;

    PSToken *token = self.nextToken;

    if (!token || token.type != tokenType) {
        *error = [NSError errorWithDomain: PSParserErrorDomain code: 1 userInfo: NULL];
        return NULL;
    }

    return token;
}

- (PSSyntaxNode *) expectOneOfTokenTypes: (NSDictionary<NSNumber *, PSSyntaxNode *(^)(PSToken *)> *) tokenTypes
                                   error: (NSError **) error {
    if (*error) return NULL;

    PSToken *token = self.nextToken;

    if (!token) {
        *error = [NSError errorWithDomain: PSParserErrorDomain code: 1 userInfo: NULL];
        return NULL;
    }

    NSNumber *key = [NSNumber numberWithInt: token.type];
    PSSyntaxNode *(^block)(PSToken *) = tokenTypes[key];

    if (!block) {
        *error = [NSError errorWithDomain: PSParserErrorDomain code: 1 userInfo: NULL];
        return NULL;
    }

    return block(token);
}

- (NSArray<PSSyntaxNode *> *) expectMultipleOfTokenTypes: (NSDictionary<NSNumber *, PSSyntaxNode *(^)(PSToken *)> *) tokenTypes
                                                   error: (NSError **) error {
    if (*error) return NULL;

    PSToken *token;
    NSMutableArray *children = [[NSMutableArray alloc] init];

    do {
        token = self.nextToken;
        if (!token) break;

        NSNumber *key = [NSNumber numberWithInt: token.type];
        PSSyntaxNode *(^block)(PSToken *) = tokenTypes[key];
        PSSyntaxNode *node = block(token);

        if (node) [children addObject: node];
    } while (!*error && token != NULL);

    if (*error) return NULL;
    return children;
}

#pragma mark - Resetting

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
