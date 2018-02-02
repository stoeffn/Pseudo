//
//  PSSyntaxNodeKeyword.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "PSSyntaxNodeReturn.h"
#import "PSSyntaxNodeExpression.h"
#import "PSToken.h"

@implementation PSSyntaxNodeReturn

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<PSSyntaxNodeReturn children: %@>", self.children];
}

+ (PSSyntaxNodeReturn *) nextReturnSyntaxNodeFor: (NSMutableArray *) tokens {
    PSSyntaxNodeReturn *node = [[PSSyntaxNodeReturn alloc] init];
    PSToken *nextToken;

    NSMutableArray *bodyTokens = [[NSMutableArray alloc] init];

    do {
        nextToken = [tokens dequeue];
        [bodyTokens enqueue: nextToken];
    } while (nextToken != NULL && nextToken.type != PSTokenTypePoint);

    PSSyntaxNodeExpression *bodyNode = [PSSyntaxNodeExpression nextExpressionSyntaxNodeFor: bodyTokens];
    if (bodyNode == NULL) {
        return NULL;
    }
    [node.children enqueue: bodyNode];

    return node;
}

@end
