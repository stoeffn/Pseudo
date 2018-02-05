//
//  PSControlFlowNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSControlFlowNode.h"
#import "PSControlFlowNode+Types.h"

@implementation PSControlFlowNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSControlFlowTypes) type
                                  node: (nullable PSNode *) node {
    if (self = [super initWithToken: token]) {
        _type = type;
        _node = node;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSControlFlowTypes) type
                                 node: (nullable PSNode *) node {
    return [self initWithToken: NULL type: type node: node];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, type: %@, node: %@>",
            NSStringFromClass([self class]), self.token, [PSControlFlowNode descriptionForType: self.type], self.node];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToControlFlowNode: (PSControlFlowNode *) object];
}

- (BOOL) isEqualToControlFlowNode: (PSControlFlowNode *) node {
    return node != NULL
        && ((!self.node && !node.node) || [self.node isEqual: node.node]);
}

@end
