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
    PSToken *token = [self.lexer expectTokenTypes: PSTokenTypesNumber error: error];

    if (*error) return NULL;

    NSNumber *type = [PSLiteralNode typeForTokenType: token.type];
    if (!type) return NULL;

    return [[PSLiteralNode alloc] initWithToken: token
                                           type: type.integerValue
                                         string: NULL
                                         number: token.number];
}

@end
