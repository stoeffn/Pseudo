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
#import "PSBinaryOperationNode.h"
#import "PSBinaryOperationNode+Types.h"
#import "PSLiteralNode.h"
#import "PSLiteralNode+Types.h"
#import "PSUnaryOperationNode.h"
#import "PSUnaryOperationNode+Types.h"
#import "PSControlFlowNode.h"
#import "PSControlFlowNode+Types.h"

@implementation PSParser

#pragma mark - Life Cycle

- (instancetype) initWithLexer: (nonnull id<PSLexing>) lexer {
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

#pragma mark Statements

- (nullable PSNode *) statementWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSError *controlFlowError;
    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesBreak), @(PSTokenTypesContinue), @(PSTokenTypesReturn));
    PSToken *token = [self.lexer expectOneOfTokenTypes: allowedTokenTypes error: &controlFlowError];

    if (token) {
        NSError *returnExpressionError;
        PSNode *returnExpressionNode = token.type == PSTokenTypesReturn
            ? [self expressionWithError: &returnExpressionError]
            : NULL;

        return [[PSControlFlowNode alloc] initWithToken: self.lexer.currentToken
                                                   type: [PSControlFlowNode typeForTokenType: token.type].integerValue
                                                   node: returnExpressionNode];
    }

    return [self expressionWithError: error];
}

#pragma mark Expressions

- (nullable PSNode *) expressionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node;
    PSToken *token = self.lexer.currentToken;

    if (token.type == PSTokenTypesNot) {
        [self.lexer advance];
        node = [[PSUnaryOperationNode alloc] initWithToken: token
                                                      type: PSUnaryOperationTypesNot
                                                      node: [self expressionWithError: error]];
    } else {
        node = [self termWithError: error];

        NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesPlus), @(PSTokenTypesMinus));
        TokenHandler handler = ^(PSToken *token) {
            NSNumber *type = [PSBinaryOperationNode typeForTokenType: token.type];
            if (!type) return;

            node = [[PSBinaryOperationNode alloc] initWithToken: token
                                                           type: type.integerValue
                                                           left: node
                                                          right: [self termWithError: error]];
        };
        [self.lexer expectMultipleOfTokenTypes: allowedTokenTypes handler: handler error: error];
    }

    node = [self optionalComparisonWithLeftNode: node error: error];

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) optionalComparisonWithLeftNode: (PSNode *) node
                                               error: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSError *comparisonError;
    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesEquals), @(PSTokenTypesNotEquals),
                                                @(PSTokenTypesGreaterThan), @(PSTokenTypesGreaterThanOrEquals),
                                                @(PSTokenTypesLessThan), @(PSTokenTypesLessThanOrEquals));
    PSToken *token = [self.lexer expectOneOfTokenTypes: allowedTokenTypes error: &comparisonError];
    if (!token) return node;

    return [[PSBinaryOperationNode alloc] initWithToken: token
                                                   type: [PSBinaryOperationNode typeForTokenType: token.type].integerValue
                                                   left: node
                                                  right: [self expressionWithError: error]];
}

- (nullable PSNode *) termWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node = [self scalarWithError: error];

    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesTimes), @(PSTokenTypesDividedBy),
                                                @(PSTokenTypesDividedAsIntegerBy), @(PSTokenTypesModulo));
    TokenHandler handler = ^(PSToken *token) {
        node = [[PSBinaryOperationNode alloc] initWithToken: token
                                                       type: [PSBinaryOperationNode typeForTokenType: token.type].integerValue
                                                       left: node
                                                      right: [self scalarWithError: error]];
    };
    [self.lexer expectMultipleOfTokenTypes: allowedTokenTypes handler: handler error: error];

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) scalarWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    PSNode *node;
    PSToken *token = self.lexer.currentToken;

    if (token.type == PSTokenTypesOpeningParenthesis) {
        [self.lexer advance];
        node = [self expressionWithError: error];
        [self.lexer expectTokenTypes: PSTokenTypesClosingParanthesis error: error];
    } else if (token.type == PSTokenTypesMinus) {
        [self.lexer advance];
        node = [[PSUnaryOperationNode alloc] initWithToken: token
                                                      type: PSUnaryOperationTypesNegation
                                                      node: [self scalarWithError: error]];
    } else {
        node = [self literalWithError: error];
    }

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) literalWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesNull), @(PSTokenTypesTrue), @(PSTokenTypesFalse),
                                                @(PSTokenTypesNumber), @(PSTokenTypesString));
    PSToken *token = [self.lexer expectOneOfTokenTypes: allowedTokenTypes error: error];

    return [[PSLiteralNode alloc] initWithToken: token
                                           type: [PSLiteralNode typeForTokenType: token.type].integerValue
                                         string: token.string
                                         number: token.number];
}

@end
