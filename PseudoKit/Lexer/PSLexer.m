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
#import "PSToken+Types.h"

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
    }
    return self;
}

#pragma mark - Description

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Reader: '%@'>", NSStringFromClass([self class]), self.reader];
}

#pragma mark - Advancing

- (nullable PSToken *) advance {
    return [self nextTokenFromReader: self.reader];
}

- (nullable PSToken *) nextTokenFromReader: (id<PSReading>) reader {
    [self skipWhitespaceAndNewlinesInReader: reader];

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
    while (self.reader.nextCharacter && [self isCharacterWhitespaceOrNewline: reader.currentCharacter]) {
        [reader advance];
    }
}

- (nullable PSToken *) nextDelimiterTokenFromReader: (id<PSReading>) reader {
    NSNumber *singleCharacterTokenType = PSToken.tokenTypes[reader.currentCharacter];

    if (reader.nextCharacter && [self isCharacterAmbiguousDelimiter: reader.currentCharacter]) {
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
    if (![reader.currentCharacter isEqualToString: PSToken.stringStartCharacter]) return NULL;
    [reader advance];

    NSMutableArray<NSString *> *buffer = [[NSMutableArray alloc] init];

    while (reader.nextCharacter) {
        if ([reader.nextCharacter isEqualToString: PSToken.stringStartCharacter]) break;

        [reader advance];
        [buffer addObject: reader.currentCharacter];
    };

    [reader advance];

    NSString *string = [self rawTokenFromBuffer: buffer];
    return [[PSToken alloc] initWithType: PSTokenTypesString string: string];
}

- (nullable PSToken *) nextNumberTokenFromReader: (id<PSReading>) reader {
    if (![self isCharacterDigit: reader.currentCharacter]) return NULL;

    NSMutableArray<NSString *> *buffer = [[NSMutableArray alloc] init];

    BOOL isFloatingPointNumber = NO;
    while (reader.nextCharacter) {
        [buffer addObject: reader.currentCharacter];

        BOOL isFloatingPointCharacter = [reader.currentCharacter isEqualToString: PSToken.floatingPointCharacter];
        BOOL isSecondFloatingPointCharacter = isFloatingPointNumber && isFloatingPointCharacter;
        BOOL isFollowedByDigit = [self isCharacterDigit: reader.nextCharacter];

        if (isSecondFloatingPointCharacter || (isFloatingPointCharacter && !isFollowedByDigit)) break;

        [reader advance];
        isFloatingPointNumber = isFloatingPointCharacter;
    }

    NSString *rawToken = [self rawTokenFromBuffer: buffer];
    NSNumber *number = [PSToken.numberFormatter numberFromString: rawToken];

    if (number != NULL) return [[PSToken alloc] initWithType: PSTokenTypesNumber number: number];
    return NULL;
}

- (nullable PSToken *) nextKeywordOrIdentifierTokenFromReader: (id<PSReading>) reader {
    if (!reader.currentCharacter) return NULL;

    NSMutableArray<NSString *> *buffer = [[NSMutableArray alloc] init];

    while (reader.nextCharacter) {
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

- (BOOL) isCharacterWhitespaceOrNewline: (NSString *) character {
    return [character rangeOfCharacterFromSet: NSCharacterSet.whitespaceAndNewlineCharacterSet].location != NSNotFound;
}

- (BOOL) isCharacterDigit: (NSString *) character {
    return [character rangeOfCharacterFromSet: NSCharacterSet.decimalDigitCharacterSet].location != NSNotFound;
}

- (BOOL) isCharacterDelimiter: (NSString *) character {
    return [character rangeOfCharacterFromSet: PSToken.delimiterCharacterSet].location != NSNotFound;
}

- (BOOL) isCharacterAmbiguousDelimiter: (NSString *) character {
    return [character rangeOfCharacterFromSet: PSToken.ambiguousDelimiterCharacterSet].location != NSNotFound;
}

- (NSString *) rawTokenFromBuffer: (NSArray<NSString *> *) buffer {
    return [[buffer componentsJoinedByString: @""]
            stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

/*#pragma mark - Generating Tokens

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

- (PSToken *) expectTokenType: (PSTokenTypes) tokenType
                        error: (NSError **) error {
    if (*error) return NULL;

    PSToken *token = self.nextToken;

    if (!token || token.type != tokenType) {
        *error = [NSError errorWithDomain: PSParserErrorDomain code: 1 userInfo: NULL];
        return NULL;
    }

    return token;
}

- (id<PSNodeProtocol>) expectOneOfTokenTypes: (NSDictionary<NSNumber *, id<PSNodeProtocol>(^)(PSToken *)> *) tokenTypes
                                       error: (NSError **) error {
    if (*error) return NULL;

    PSToken *token = self.nextToken;

    if (!token) {
        *error = [NSError errorWithDomain: PSParserErrorDomain code: 1 userInfo: NULL];
        return NULL;
    }

    NSNumber *key = [NSNumber numberWithInt: token.type];
    id<PSNodeProtocol> (^block)(PSToken *) = tokenTypes[key];

    if (!block) {
        *error = [NSError errorWithDomain: PSParserErrorDomain code: 1 userInfo: NULL];
        return NULL;
    }

    return block(token);
}

- (NSArray<id<PSNodeProtocol>> *) expectMultipleOfTokenTypes: (NSDictionary<NSNumber *, id<PSNodeProtocol>(^)(PSToken *)> *) tokenTypes
                                           withStopTokenType: (PSTokenTypes) stopTokenType
                                                       error: (NSError **) error {
    if (*error) return NULL;

    PSToken *token;
    NSMutableArray *children = [[NSMutableArray alloc] init];

    do {
        token = self.nextToken;
        if (!token || token.type == stopTokenType) break;

        NSNumber *key = [NSNumber numberWithInt: token.type];
        id<PSNodeProtocol> (^block)(PSToken *) = tokenTypes[key];
        id<PSNodeProtocol> node = block(token);

        if (node) [children addObject: node];
    } while (!*error && token != NULL && token.type != stopTokenType);

    if (*error) return NULL;
    return children;
}*/

@end
