//
//  PSSyntaxNodeAlgorithm.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "PSSyntaxNodeAlgorithm.h"
#import "PSToken.h"
#import "PSSyntaxNode.h"
#import "PSSyntaxNodeReturn.h"

@implementation PSSyntaxNodeAlgorithm

- (instancetype) initWithIdentifier: (NSString *) identifier
                      andReturnType: (NSString *) returnType
                        andChildren: (NSMutableArray<PSSyntaxNode *> *) children {
    if (self = [super initWithChildren: children]) {
        _identifier = identifier;
        _returnType = returnType;
    }
    return self;
}

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ children: %@, identifier: %@, returnType: %@>",
            NSStringFromClass([self class]), self.children, self.identifier, self.returnType];
}

+ (PSSyntaxNode *) nextSyntaxNodeFor: (NSMutableArray<PSToken *> *) tokens {
    PSToken *nextToken = [tokens dequeue];

    switch (nextToken.type) {
        case PSTokenTypeReturn:
            return [PSSyntaxNodeReturn nextReturnSyntaxNodeFor: tokens];
        default:
            return NULL;
    }
}

+ (PSSyntaxNodeAlgorithm *) nextAlgorithmSyntaxNodeFor: (NSMutableArray *) tokens {
    PSSyntaxNodeAlgorithm *node = [[PSSyntaxNodeAlgorithm alloc] init];
    PSToken *nextToken;

    nextToken = [tokens dequeue];
    if (nextToken.type != PSTokenTypeIdentifier) {
        return NULL;
    }
    node.identifier = nextToken.value;

    nextToken = [tokens dequeue];
    if (nextToken.type != PSTokenTypeOpeningParenthesis) {
        return NULL;
    }

    nextToken = [tokens dequeue];
    if (nextToken.type != PSTokenTypeClosingParenthesis) {
        return NULL;
    }

    nextToken = [tokens dequeue];
    if (nextToken.type != PSTokenTypeColon) {
        return NULL;
    }

    NSMutableArray *bodyTokens = [[NSMutableArray alloc] init];
    NSMutableArray *bodyNodes = [[NSMutableArray alloc] init];

    while (nextToken != NULL && nextToken.type != PSTokenTypePoint) {
        nextToken = [tokens dequeue];
        [bodyTokens enqueue: nextToken];
    }

    while (bodyTokens.count > 0) {
        PSSyntaxNode *node = [self nextSyntaxNodeFor: bodyTokens];
        if (node != NULL) {
            [bodyNodes enqueue: node];
        }
    }

    node.children = bodyNodes;

    return node;
}

@end
