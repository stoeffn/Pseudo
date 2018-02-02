//
//  PSSyntaxNodeExpression.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "PSSyntaxNodeExpression.h"
#import "PSSyntaxNodeNumberLiteral.h"
#import "PSToken.h"

@implementation PSSyntaxNodeExpression

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<PSSyntaxNodeExpression children: %@>", self.children];
}

+ (PSSyntaxNodeExpression *) nextExpressionSyntaxNodeFor: (NSMutableArray<PSToken *> *) tokens {
    PSSyntaxNodeExpression *node = [[PSSyntaxNodeExpression alloc] init];
    PSToken *nextToken;

    nextToken = [tokens dequeue];
    if (nextToken.type != PSTokenTypeNumberLiteral) {
        return NULL;
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString: nextToken.value];
    PSSyntaxNodeNumberLiteral *body = [[PSSyntaxNodeNumberLiteral alloc] initWithValue: number];
    [node.children enqueue: body];

    return node;
}

@end
