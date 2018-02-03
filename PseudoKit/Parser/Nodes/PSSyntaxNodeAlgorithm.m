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
#import "PSLexer.h"

@implementation PSSyntaxNodeAlgorithm

- (instancetype) initWithIdentifier: (NSString *) identifier
                      andReturnType: (NSString *) returnType
                        andChildren: (NSArray<PSSyntaxNode *> *) children {
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

@end
