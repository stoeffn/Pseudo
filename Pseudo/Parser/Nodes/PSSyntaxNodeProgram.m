//
//  PSSyntaxNodeProgram.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "PSToken.h"
#import "PSSyntaxNodeProgram.h"
#import "PSSyntaxNodeAlgorithm.h"

@implementation PSSyntaxNodeProgram

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<PSSyntaxNodeProgram children: %@>", self.children];
}

+ (PSSyntaxNodeProgram *) nextProgramSyntaxNodeFor: (NSMutableArray<PSToken *> *) tokens {
    PSSyntaxNodeProgram *node = [[PSSyntaxNodeProgram alloc] init];

    while (tokens.count > 0) {
        PSSyntaxNode *body = [PSSyntaxNodeProgram nextSyntaxNodeFor: tokens];
        if (body != NULL) {
            [node.children enqueue: body];
        }
    }

    return node;
}

+ (PSSyntaxNode *) nextSyntaxNodeFor: (NSMutableArray<PSToken *> *) tokens {
    PSToken *nextToken = [tokens dequeue];

    switch (nextToken.type) {
        case PSTokenTypeAlgorithm:
            return [PSSyntaxNodeAlgorithm nextAlgorithmSyntaxNodeFor: tokens];
        default:
            return NULL;
    }
}

@end
