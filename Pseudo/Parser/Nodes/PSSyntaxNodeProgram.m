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
    PSSyntaxNodeProgram *program = [[PSSyntaxNodeProgram alloc] init];

    while (tokens.count > 0) {
        PSSyntaxNode *node = [PSSyntaxNodeProgram nextSyntaxNodeFor: tokens];
        if (node != NULL) {
            [program.children enqueue: node];
        }
    }

    return program;
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
