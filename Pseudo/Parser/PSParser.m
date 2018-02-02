//
//  PSParser.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "PSParser.h"
#import "PSSyntaxNode.h"
#import "PSSyntaxNodeProgram.h"
#import "PSSyntaxNodeAlgorithm.h"

@implementation PSParser

- (instancetype) init {
    if (self = [super init]) {
        _tokens = [[NSArray alloc] init];
    }
    return self;
}

- (instancetype) initWithTokens: (NSArray<PSToken *> *) tokens {
    if (self = [self init]) {
        _tokens = tokens;
    }
    return self;
}

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<PSParser tokens: %@, program: %@>", self.tokens, self.program];
}

- (PSSyntaxNodeProgram *) program {
    NSMutableArray *tokens = [[NSMutableArray alloc] initWithArray: self.tokens];
    return [PSSyntaxNodeProgram nextProgramSyntaxNodeFor: tokens];
}

@end
