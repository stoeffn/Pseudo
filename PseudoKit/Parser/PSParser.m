//
//  PSParser.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSMacros.h"
#import "PSParser.h"
#import "PSToken.h"
#import "PSAlgorithmNode.h"
#import "PSBinaryOperationNode.h"
#import "PSBinaryOperationNode+Types.h"
#import "PSCallNode.h"
#import "PSCompoundNode.h"
#import "PSConditionNode.h"
#import "PSControlFlowNode.h"
#import "PSControlFlowNode+Types.h"
#import "PSLiteralNode.h"
#import "PSLiteralNode+Types.h"
#import "PSParameterNode.h"
#import "PSUnaryOperationNode.h"
#import "PSUnaryOperationNode+Types.h"

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
    return [[NSString alloc] initWithFormat: @"<%@ lexer: %@>", NSStringFromClass([self class]), self.lexer];
}

#pragma mark - Parsing

- (nullable PSNode *) programWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    return [self blockListWithStopTokenType: NULL error: error];
}

#pragma mark Blocks

- (nullable PSNode *) blockListWithStopTokenType: (nullable NSNumber *) stopTokenType
                                           error: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    if (stopTokenType && self.lexer.currentToken.type == stopTokenType.integerValue) {
        [self.lexer expectTokenTypes: stopTokenType.integerValue error: error];

        if (*error) return NULL;
        return [[PSCompoundNode alloc] initWithNodes: @[]];
    }

    NSMutableArray<PSNode *> *nodes = [[NSMutableArray alloc] initWithObjects: [self blockWithError: error], nil];

    while (self.lexer.currentToken && (!stopTokenType || self.lexer.currentToken.type != stopTokenType.integerValue)) {
        PSNode *node = [self blockWithError: error];
        if (*error) return NULL;

        [nodes addObject: node];
    }

    if (stopTokenType) [self.lexer expectTokenTypes: stopTokenType.integerValue error: error];

    if (*error) return NULL;
    return [[PSCompoundNode alloc] initWithNodes: nodes];
}

- (nullable PSNode *) blockWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    switch (self.lexer.currentToken.type) {
        case PSTokenTypesAlgorithm:
            return [self algorithmWithError: error];
        case PSTokenTypesIf:
            return [self conditionWithError: error];
        case PSTokenTypesWhile:
            return [self whileLoopWithError: error];
        case PSTokenTypesRepeat:
            return [self repeatLoopWithError: error];
        case PSTokenTypesFor:
            return [self forLoopWithError: error];
        default:
            return [self statementListWithError: error];
    }
}

#pragma mark Statements

- (nullable PSNode *) statementListWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSMutableArray<PSNode *> *nodes = [[NSMutableArray alloc] initWithObjects: [self statementWithError: error], nil];

    while (self.lexer.currentToken.type == PSTokenTypesSemicolon) {
        [self.lexer expectTokenTypes: PSTokenTypesSemicolon error: error];

        PSNode *node = [self statementWithError: error];
        if (*error) return NULL;

        [nodes addObject: node];
    }

    if (*error) return NULL;
    return [[PSCompoundNode alloc] initWithNodes: nodes];
}

- (nullable PSNode *) statementWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSError *controlFlowError;
    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesBreak), @(PSTokenTypesContinue), @(PSTokenTypesReturn));
    PSToken *token = [self.lexer expectOneOfTokenTypes: allowedTokenTypes error: &controlFlowError];

    if (token) {
        NSError *returnExpressionError;
        PSNode *returnExpressionNode = token.type == PSTokenTypesReturn
            ? [self expressionWithError: &returnExpressionError]
            : NULL;

        if (*error) return NULL;
        return [[PSControlFlowNode alloc] initWithToken: self.lexer.currentToken
                                                   type: [PSControlFlowNode typeForTokenType: token.type].integerValue
                                         expressionNode: returnExpressionNode];
    }

    if (*error) return NULL;
    return [self expressionWithError: error];
}

#pragma mark Conditions

- (nullable PSNode *) conditionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    PSToken *ifToken = [self.lexer expectTokenTypes: PSTokenTypesIf error: error];
    PSNode *expressionNode = [self expressionWithError: error];
    [self.lexer expectTokenTypes: PSTokenTypesThen error: error];
    PSNode *thenNode = [self blockListWithStopTokenType: @(PSTokenTypesPoint) error: error];
    PSNode *elseNode;

    if (self.lexer.currentToken.type == PSTokenTypesElse) {
        [self.lexer expectTokenTypes: PSTokenTypesElse error: error];
        elseNode = [self blockListWithStopTokenType: @(PSTokenTypesPoint) error: error];
    }

    if (*error) return NULL;
    return [[PSConditionNode alloc] initWithToken: ifToken
                                   expressionNode: expressionNode
                                         thenNode: thenNode
                                         elseNode: elseNode];
}

#pragma mark Algorithms

- (nullable PSNode *) algorithmWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    PSToken *typeIdentifierToken;
    PSToken *returnTypeIdentifierToken;
    PSToken *algorithmToken = [self.lexer expectTokenTypes: PSTokenTypesAlgorithm error: error];
    PSToken *identifierToken = [self.lexer expectTokenTypes: PSTokenTypesIdentifier error: error];

    if (self.lexer.currentToken.type == PSTokenTypesPoint) {
        [self.lexer expectTokenTypes: PSTokenTypesPoint error: error];
        typeIdentifierToken = identifierToken;
        identifierToken = [self.lexer expectTokenTypes: PSTokenTypesIdentifier error: error];
    }

    NSArray<PSNode *> *parameterNodes = [self parameterListWithError: error];
    [self.lexer expectTokenTypes: PSTokenTypesColon error: error];

    if (self.lexer.currentToken.type == PSTokenTypesIdentifier && self.lexer.nextToken.type == PSTokenTypesColon) {
        returnTypeIdentifierToken = [self.lexer expectTokenTypes: PSTokenTypesIdentifier error: error];
        [self.lexer expectTokenTypes: PSTokenTypesColon error: error];
    }

    PSNode *bodyNode = [self blockListWithStopTokenType: @(PSTokenTypesPoint) error: error];

    if (*error) return NULL;
    return [[PSAlgorithmNode alloc] initWithToken: algorithmToken
                                   typeIdentifier: typeIdentifierToken.string
                                       identifier: identifierToken.string
                                   parameterNodes: parameterNodes
                             returnTypeIdentifier: returnTypeIdentifierToken.string
                                         bodyNode: bodyNode];
}

- (nullable NSArray<PSNode *> *) parameterListWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSMutableArray<PSNode *> *parameters = [[NSMutableArray alloc] init];
    [self.lexer expectTokenTypes: PSTokenTypesOpeningParenthesis error: error];

    while (self.lexer.currentToken.type == PSTokenTypesIdentifier) {
        PSToken *typeIdentifierToken = [self.lexer expectTokenTypes: PSTokenTypesIdentifier error: error];
        PSToken *identifierToken = [self.lexer expectTokenTypes: PSTokenTypesIdentifier error: error];

        if (*error) return NULL;
        [parameters addObject: [[PSParameterNode alloc] initWithToken: typeIdentifierToken
                                                       typeIdentifier: typeIdentifierToken.string
                                                           identifier: identifierToken.string]];

        if (self.lexer.currentToken.type != PSTokenTypesClosingParenthesis) {
            [self.lexer expectTokenTypes: PSTokenTypesComma error: error];
        }
    }

    [self.lexer expectTokenTypes: PSTokenTypesClosingParenthesis error: error];

    if (*error) return NULL;
    return parameters;
}

#pragma mark Loops

- (nullable PSNode *) whileLoopWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSLog(@"While loops are not supported yet.");
    return NULL;
}

- (nullable PSNode *) repeatLoopWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSLog(@"Repeat loops are not supported yet.");
    return NULL;
}

- (nullable PSNode *) forLoopWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSLog(@"For loops are not supported yet.");
    return NULL;
}

#pragma mark Expressions

- (nullable PSNode *) expressionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node;
    PSToken *token = self.lexer.currentToken;

    if (token.type == PSTokenTypesNot) {
        [self.lexer expectTokenTypes: PSTokenTypesNot error: error];
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
                                                       leftNode: node
                                                      rightNode: [self termWithError: error]];
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
                                               leftNode: node
                                              rightNode: [self expressionWithError: error]];
}

- (nullable PSNode *) termWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    __block PSNode *node = [self scalarWithError: error];

    NSSet<NSNumber *> *allowedTokenTypes = $set(@(PSTokenTypesTimes), @(PSTokenTypesDividedBy),
                                                @(PSTokenTypesDividedAsIntegerBy), @(PSTokenTypesModulo));
    TokenHandler handler = ^(PSToken *token) {
        node = [[PSBinaryOperationNode alloc] initWithToken: token
                                                       type: [PSBinaryOperationNode typeForTokenType: token.type].integerValue
                                                   leftNode: node
                                                  rightNode: [self scalarWithError: error]];
    };
    [self.lexer expectMultipleOfTokenTypes: allowedTokenTypes handler: handler error: error];

    if (*error) return NULL;
    return node;
}

- (nullable PSNode *) scalarWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    PSNode *node;
    PSToken *token = self.lexer.currentToken;

    if (token.type == PSTokenTypesOpeningParenthesis) {
        [self.lexer expectTokenTypes: PSTokenTypesOpeningParenthesis error: error];
        node = [self expressionWithError: error];
        [self.lexer expectTokenTypes: PSTokenTypesClosingParenthesis error: error];
    } else if (token.type == PSTokenTypesMinus) {
        [self.lexer expectTokenTypes: PSTokenTypesMinus error: error];
        node = [[PSUnaryOperationNode alloc] initWithToken: token
                                                      type: PSUnaryOperationTypesNegation
                                                      node: [self scalarWithError: error]];
    } else if (token.type == PSTokenTypesIdentifier) {
        node = [self anyCallWithError: error];
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

    if (*error) return NULL;
    return [[PSLiteralNode alloc] initWithToken: token
                                           type: [PSLiteralNode typeForTokenType: token.type].integerValue
                                         string: token.string
                                         number: token.number];
}

#pragma mark Calls

- (nullable PSNode *) anyCallWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    PSToken *identifierToken = [self.lexer expectTokenTypes: PSTokenTypesIdentifier error: error];

    if (self.lexer.currentToken.type == PSTokenTypesOpeningParenthesis) {
        NSArray<PSNode *> *callArgumentNodes = [self callArgumentsWithError: error];

        if (*error) return NULL;
        return [[PSCallNode alloc] initWithToken: identifierToken
                                            type: PSCallTypesFunction
                                     chainedNode: NULL
                                      identifier: identifierToken.string
                                   argumentNodes: callArgumentNodes];
    }

    if (*error) return NULL;
    return [[PSCallNode alloc] initWithToken: identifierToken
                                        type: PSCallTypesVariable
                                 chainedNode: NULL
                                  identifier: identifierToken.string
                               argumentNodes: NULL];
}

- (nullable NSArray<PSNode *> *) callArgumentsWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    NSMutableArray<PSNode *> *argumentNodes = [[NSMutableArray alloc] init];

    [self.lexer expectTokenTypes: PSTokenTypesOpeningParenthesis error: error];

    while (self.lexer.currentToken.type != PSTokenTypesClosingParenthesis) {
        PSNode *expressionNode = [self expressionWithError: error];

        if (*error) return NULL;
        [argumentNodes addObject: expressionNode];

        if (self.lexer.currentToken.type != PSTokenTypesClosingParenthesis) {
            [self.lexer expectTokenTypes: PSTokenTypesComma error: error];
        }
    }

    [self.lexer expectTokenTypes: PSTokenTypesClosingParenthesis error: error];

    if (*error) return NULL;
    return argumentNodes;
}

@end
