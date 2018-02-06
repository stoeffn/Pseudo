//
//  PSCompoundNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSCompoundNode.h"

@implementation PSCompoundNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                 nodes: (nonnull NSArray<PSNode *> *) nodes {
    if (self = [super initWithToken: token]) {
        _nodes = nodes;
    }
    return self;
}

- (nonnull instancetype) initWithNodes: (nonnull NSArray<PSNode *> *) nodes {
    return [self initWithToken: NULL nodes: nodes];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, nodes: %@>",
            NSStringFromClass([self class]), self.token, self.nodes];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToCompoundNode: (PSCompoundNode *) object];
}

- (BOOL) isEqualToCompoundNode: (PSCompoundNode *) node {
    return node != NULL
        && [self.nodes isEqual: node.nodes];
}

@end
