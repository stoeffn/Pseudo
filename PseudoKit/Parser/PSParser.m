//
//  PSParser.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "Constants.h"
#import "PSParser.h"
#import "PSToken.h"
#import "PSLexer.h"
#import "PSSyntaxNode.h"
#import "PSSyntaxNodeProgram.h"
#import "PSSyntaxNodeAlgorithm.h"

@implementation PSParser

#pragma mark - Life Cycle

- (instancetype) initWithLexer: (nonnull PSLexer *) lexer {
    if (self = [super init]) {
        _lexer = lexer;
    }
    return self;
}

#pragma mark - Description

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ lexer: %@>",
            NSStringFromClass([self class]), self.lexer];
}

#pragma mark - Parsing

- (PSSyntaxNodeProgram *) programWithError: (NSError **) error {
    PSToken *token;
    NSMutableArray *children = [[NSMutableArray alloc] init];

    do {
        token = [self.lexer nextToken];
        if (!token) break;

        PSSyntaxNode *child;

        switch (token.type) {
            case PSTokenTypeAlgorithm:
                child = [self algorithmWithError: error];
                break;
            default:
                *error = [NSError errorWithDomain: PSParserErrorDomain code: 1 userInfo: NULL];
                break;
        }

        if (child) [children addObject: child];
    } while (!*error && token != NULL);

    if (*error) return NULL;
    return [[PSSyntaxNodeProgram alloc] initWithChildren: children];
}

- (PSSyntaxNodeAlgorithm *) algorithmWithError: (NSError **) error {
    PSToken *identifier = [self.lexer expectTokenType: PSTokenTypeIdentifier error: error];
    [self.lexer expectTokenType: PSTokenTypeOpeningParenthesis error: error];
    [self.lexer expectTokenType: PSTokenTypeClosingParenthesis error: error];
    [self.lexer expectTokenType: PSTokenTypeColon error: error];
    [self.lexer expectTokenType: PSTokenTypePoint error: error];

    if (*error) return NULL;
    return [[PSSyntaxNodeAlgorithm alloc] initWithIdentifier: identifier.value andReturnType: NULL andChildren: NULL];
}

@end
