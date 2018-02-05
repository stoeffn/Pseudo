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

- (nullable PSNode *) expressionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node = [self termWithError: error];

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

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) termWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node = [self scalarWithError: error];

    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesTimes), @(PSTokenTypesDividedBy),
                                                @(PSTokenTypesDividedAsIntegerBy), @(PSTokenTypesModulo));
    TokenHandler handler = ^(PSToken *token) {
        NSNumber *type = [PSBinaryOperationNode typeForTokenType: token.type];
        if (!type) return;

        node = [[PSBinaryOperationNode alloc] initWithToken: token
                                                       type: type.integerValue
                                                       left: node
                                                      right: [self scalarWithError: error]];
    };
    [self.lexer expectMultipleOfTokenTypes: allowedTokenTypes handler: handler error: error];

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) scalarWithError: (NSError * __nullable * __null_unspecified) error {
    PSNode *node;

    if (self.lexer.currentToken.type == PSTokenTypesOpeningParenthesis) {
        [self.lexer advance];
        node = [self expressionWithError: error];
        [self.lexer expectTokenTypes: PSTokenTypesClosingParanthesis error: error];
    } else {
        node = [self literalWithError: error];
    }

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) literalWithError: (NSError * __nullable * __null_unspecified) error {
    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesNull), @(PSTokenTypesTrue), @(PSTokenTypesFalse),
                                                @(PSTokenTypesNumber), @(PSTokenTypesString));
    PSToken *token = [self.lexer expectOneOfTokenTypes: allowedTokenTypes error: error];

    NSNumber *type = [PSLiteralNode typeForTokenType: token.type];
    if (!type) return NULL;

    return [[PSLiteralNode alloc] initWithToken: token
                                           type: type.integerValue
                                         string: token.string
                                         number: token.number];
}

@end
