//
//  PSLexer.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSConstants.h"
#import "PSMacros.h"
#import "PSLexer.h"
#import "PSToken.h"
#import "PSToken+Types.h"
#import "PSParser+Errors.h"

@interface PSLexer ()

#pragma mark - State

@property (nonatomic, nonnull) id<PSReading> reader;

@property (nonatomic, nullable) PSToken *currentToken;

@property (nonatomic, nullable) PSToken *nextToken;

@end

@implementation PSLexer

#pragma mark - Life Cycle

- (nonnull instancetype) initWithReader: (nonnull id<PSReading>) reader {
    if (self = [super init]) {
        _reader = reader;

        [self advanceToFirstToken];
    }
    return self;
}

#pragma mark - Description

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Reader: '%@'>", NSStringFromClass([self class]), self.reader];
}

#pragma mark - Advancing

- (nullable PSToken *) advance {
    self.currentToken = self.nextToken;
    self.nextToken = [self nextTokenFromReader: self.reader];
    return self.nextToken;
}

- (void) advanceToFirstToken {
    [self advance];
    [self advance];
}

- (nullable PSToken *) nextTokenFromReader: (id<PSReading>) reader {
    [self skipWhitespaceAndNewlinesInReader: reader];
    [self skipCommentsInReader: reader];

    PSToken *delimiterToken = [self nextDelimiterTokenFromReader: reader];
    if (delimiterToken) return delimiterToken;

    PSToken *stringToken = [self nextStringTokenFromReader: reader];
    if (stringToken) return stringToken;

    PSToken *numberToken = [self nextNumberTokenFromReader: reader];
    if (numberToken) return numberToken;

    PSToken *keywordOrIdentifierToken = [self nextKeywordOrIdentifierTokenFromReader: reader];
    if (keywordOrIdentifierToken) return keywordOrIdentifierToken;

    return NULL;
}

- (void) skipWhitespaceAndNewlinesInReader: (id<PSReading>) reader {
    while (reader.nextCharacter && [self isCharacterWhitespaceOrNewline: reader.currentCharacter]) {
        [reader advance];
    }
}

- (void) skipCommentsInReader: (id<PSReading>) reader {
    BOOL isCommentStartCharacter = [reader.currentCharacter isEqualToString: PSToken.commentStartCharacter];
    BOOL isFollowedByCommentStartCharacter = [reader.nextCharacter isEqualToString: PSToken.commentStartCharacter];

    if (!isCommentStartCharacter || !isFollowedByCommentStartCharacter) return;

    while (reader.currentCharacter && ![self isCharacterNewline: reader.currentCharacter]) {
        [reader advance];
    }
}

- (nullable PSToken *) nextDelimiterTokenFromReader: (id<PSReading>) reader {
    NSNumber *singleCharacterTokenType = PSToken.tokenTypes[reader.currentCharacter];

    if ([self isCharacterAmbiguousDelimiter: reader.currentCharacter] && reader.nextCharacter) {
        NSString *doubleCharacterRawToken = [self rawTokenFromBuffer: @[reader.currentCharacter, reader.nextCharacter]];
        NSNumber *doubleCharacterTokenType = PSToken.tokenTypes[doubleCharacterRawToken];

        if (doubleCharacterTokenType) {
            [reader advance];
            [reader advance];
            return [[PSToken alloc] initWithType: doubleCharacterTokenType.intValue];
        }
    }

    if (singleCharacterTokenType) {
        [reader advance];
        return [[PSToken alloc] initWithType: singleCharacterTokenType.intValue];
    }

    return NULL;
}

- (nullable PSToken *) nextStringTokenFromReader: (id<PSReading>) reader {
    if (![reader.currentCharacter isEqualToString: PSToken.stringDelimiterCharacter]) return NULL;

    [reader advance];

    NSMutableArray<NSString *> *buffer = [[NSMutableArray alloc] init];
    BOOL wasLastCharacterEscaping = NO;

    while (reader.currentCharacter) {
        BOOL isEscapeCharacter = [reader.currentCharacter isEqualToString: PSToken.stringEscapeCharacter];
        BOOL isStringDelimiterCharacter = [reader.currentCharacter isEqualToString: PSToken.stringDelimiterCharacter];

        if (wasLastCharacterEscaping) {
            NSString *escapedCharacter = PSToken.escapableCharacters[reader.currentCharacter];
            [buffer addObject: escapedCharacter ? escapedCharacter : reader.currentCharacter];
        } else if (isStringDelimiterCharacter) {
            break;
        } else if (!isEscapeCharacter) {
            [buffer addObject: reader.currentCharacter];
        }

        wasLastCharacterEscaping = isEscapeCharacter;
        [reader advance];
    }

    [reader advance];

    NSString *string = [self rawTokenFromBuffer: buffer];
    return [[PSToken alloc] initWithType: PSTokenTypesString string: string];
}

- (nullable PSToken *) nextNumberTokenFromReader: (id<PSReading>) reader {
    if (![self isCharacterDigit: reader.currentCharacter]) return NULL;

    NSMutableArray<NSString *> *buffer = [[NSMutableArray alloc] init];

    BOOL isFloatingPointNumber = NO;
    while (reader.currentCharacter) {
        BOOL isDigit = [self isCharacterDigit: reader.currentCharacter];
        BOOL isFollowedByDigit = [self isCharacterDigit: reader.nextCharacter];
        BOOL isFloatingPointCharacter = [reader.currentCharacter isEqualToString: PSToken.floatingPointCharacter];
        BOOL isDigitOrFloatingPointCharacter = isDigit || isFloatingPointCharacter;
        BOOL isSecondFloatingPointCharacter = isFloatingPointNumber && isFloatingPointCharacter;
        BOOL isPoint = isFloatingPointCharacter && !isFollowedByDigit;

        if (!isDigitOrFloatingPointCharacter || isSecondFloatingPointCharacter || isPoint) break;

        [buffer addObject: reader.currentCharacter];
        [reader advance];

        isFloatingPointNumber = isFloatingPointCharacter;
    }

    NSString *rawToken = [self rawTokenFromBuffer: buffer];
    NSNumber *number = [PSToken.numberFormatter numberFromString: rawToken];

    return [[PSToken alloc] initWithType: PSTokenTypesNumber number: number];
}

- (nullable PSToken *) nextKeywordOrIdentifierTokenFromReader: (id<PSReading>) reader {
    if (!reader.currentCharacter) return NULL;

    NSMutableArray<NSString *> *buffer = [[NSMutableArray alloc] init];

    while (reader.currentCharacter) {
        [buffer addObject: reader.currentCharacter];
        
        if (![self isCharacterDelimiter: reader.currentCharacter] && [self isCharacterDelimiter: reader.nextCharacter]) break;

        [reader advance];
    }

    [reader advance];

    NSString *rawToken = [self rawTokenFromBuffer: buffer];
    NSNumber *keywordTokenType = PSToken.tokenTypes[rawToken];

    if (keywordTokenType) return [[PSToken alloc] initWithType: keywordTokenType.intValue];
    return [[PSToken alloc] initWithType: PSTokenTypesIdentifier string: rawToken];
}

#pragma mark - Helpers

- (BOOL) isCharacterNewline: (NSString *) character {
    return [character rangeOfCharacterFromSet: NSCharacterSet.newlineCharacterSet].location != NSNotFound;
}

- (BOOL) isCharacterWhitespaceOrNewline: (NSString *) character {
    return [character rangeOfCharacterFromSet: NSCharacterSet.whitespaceAndNewlineCharacterSet].location != NSNotFound;
}

- (BOOL) isCharacterDigit: (NSString *) character {
    return character && [character rangeOfCharacterFromSet: NSCharacterSet.decimalDigitCharacterSet].location != NSNotFound;
}

- (BOOL) isCharacterDelimiter: (NSString *) character {
    return character && [character rangeOfCharacterFromSet: PSToken.delimiterCharacterSet].location != NSNotFound;
}

- (BOOL) isCharacterAmbiguousDelimiter: (NSString *) character {
    return character && [character rangeOfCharacterFromSet: PSToken.ambiguousDelimiterCharacterSet].location != NSNotFound;
}

- (nonnull NSString *) rawTokenFromBuffer: (NSArray<NSString *> *) buffer {
    return [[buffer componentsJoinedByString: @""]
            stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

#pragma mark - Asserting Tokens

- (nullable PSToken *) expectTokenTypes: (PSTokenTypes) tokenType
                                  error: (NSError * __nullable * __null_unspecified) error {
    return [self expectOneOfTokenTypes: $set(@(tokenType)) error: error];
}

- (nullable PSToken *) expectOneOfTokenTypes: (nonnull NSSet<NSNumber *> *) tokenTypes
                                       error: (NSError * __nullable * __null_unspecified) error {
    if (*error) return NULL;

    PSToken *token = self.currentToken;

    if (!token) {
        *error = PSParser.endOfFileError;
        return NULL;
    }

    if (![tokenTypes containsObject: @(token.type)]) {
        *error = [PSParser expectedOneOfTokenTypes: tokenTypes butFoundTokenTypeError: token.type];
        return NULL;
    }

    [self advance];
    return token;
}

- (BOOL) expectMultipleOfTokenTypes: (nonnull NSSet<NSNumber *> *) tokenTypes
                            handler: (nonnull TokenHandler) handler
                              error: (NSError * __nullable * __null_unspecified) error {
    if (*error) return NO;

    while (self.currentToken && [tokenTypes containsObject: @(self.currentToken.type)]) {
        PSToken *token = self.currentToken;
        [self advance];
        handler(token);
    }

    return YES;
}

@end
