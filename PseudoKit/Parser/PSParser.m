//
//  PSParser.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "Constants.h"
#import "Macros.h"
#import "PSParser.h"
#import "PSToken.h"
#import "PSLexer.h"
#import "PSBinaryOperationNode.h"
#import "PSNumberLiteralNode.h"

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

/*- (PSProgramNode *) programWithError: (NSError * __nullable * __null_unspecified) error {
    NSArray<id<PSBlockNodeProtocol>> *blocks = [self blockListWithError: error];

    if (*error) return NULL;
    return [[PSProgramNode alloc] initWithBlocks: blocks];
}

- (NSArray<id<PSBlockNodeProtocol>> *) blockListWithError: (NSError * __nullable * __null_unspecified) error {
    if (*error) return NULL;
    return NULL;
}

- (id<PSBlockNodeProtocol>) blockWithError: (NSError * __nullable * __null_unspecified) error {
    if (*error) return NULL;
    return NULL;
}

- (NSArray<id<PSStatementNodeProtocol>> *) statementListWithError: (NSError * __nullable * __null_unspecified) error {
    if (*error) return NULL;
    return NULL;
}

- (id<PSStatementNodeProtocol>) statementWithError: (NSError * __nullable * __null_unspecified) error {
    if (*error) return NULL;
    return NULL;
}*/

- (nullable PSNode *) expressionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node = [self termWithError: error];

    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesPlus), @(PSTokenTypesMinus));
    TokenHandler handler = ^(PSToken *token) {
        node = [[PSBinaryOperationNode alloc] initWithToken: token left: node right: [self termWithError: error]];
    };
    [self.lexer expectMultipleOfTokenTypes: allowedTokenTypes handler: handler error: error];

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) termWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node = [self scalarWithError: error];

    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesTimes), @(PSTokenTypesDividedBy),
                                                @(PSTokenTypesDividedAsIntegerBy), @(PSTokenTypesModulo));
    TokenHandler handler = ^(PSToken *token) {
        node = [[PSBinaryOperationNode alloc] initWithToken: token left: node right: [self scalarWithError: error]];
    };
    [self.lexer expectMultipleOfTokenTypes: allowedTokenTypes handler: handler error: error];

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) scalarWithError: (NSError * __nullable * __null_unspecified) error {
    PSToken *numberLiteral = [self.lexer expectTokenTypes: PSTokenTypesNumber error: error];

    if (*error) return NULL;
    return [[PSNumberLiteralNode alloc] initWithToken: numberLiteral value: numberLiteral.number];
}

/*- (PSAlgorithmNode *) algorithmWithError: (__autoreleasing NSError **) error {
    PSToken *identifier = [self.lexer expectTokenType: PSTokenTypeIdentifier error: error];
    [self.lexer expectTokenType: PSTokenTypeOpeningParenthesis error: error];
    [self.lexer expectTokenType: PSTokenTypeClosingParenthesis error: error];
    [self.lexer expectTokenType: PSTokenTypeColon error: error];

    NSDictionary *expectedTokenTypes = @{[NSNumber numberWithInt: PSTokenTypeReturn]: ^id<PSNodeProtocol>(PSToken *token) {
        return [self algorithmReturnWithError: error];
    }};
    NSArray *statements = [self.lexer expectMultipleOfTokenTypes: expectedTokenTypes
                                               withStopTokenType: PSTokenTypePoint
                                                           error: error];

    if (*error) return NULL;
    return [[PSAlgorithmNode alloc] initWithIdentifier: identifier.value andReturnType: NULL andStatements: statements];
}

- (PSReturnNode *) algorithmReturnWithError: (NSError **) error {
    NSError *expressionError;
    PSExpressionNode *expression = [self expressionWithError: &expressionError];

    if (!expressionError) {
        return [[PSReturnNode alloc] initWithChildren: @[expression]];
    }

    if (*error) return NULL;
    return [[PSReturnNode alloc] init];
}

- (PSExpressionNode *) expressionWithError: (NSError **) error {
    PSToken *literal = [self.lexer expectTokenType: PSTokenTypeNumberLiteral error: error];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString: literal.value];
    PSNumberLiteralNode *child = [[PSNumberLiteralNode alloc] initWithValue: number];

    if (*error) return NULL;
    return [[PSExpressionNode alloc] init];
}*/

@end
