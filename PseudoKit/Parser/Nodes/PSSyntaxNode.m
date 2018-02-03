//
//  PSSyntaxNode.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNode.h"

@implementation PSSyntaxNode

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ children: %@>",
            NSStringFromClass([self class]), self.children];
}

- (instancetype) init {
    if (self = [super init]) {
        _children = [[NSArray alloc] init];
    }
    return self;
}

- (instancetype) initWithChildren: (NSArray<PSSyntaxNode *> *) children {
    if (self = [self init]) {
        _children = children;
    }
    return self;
}

@end
