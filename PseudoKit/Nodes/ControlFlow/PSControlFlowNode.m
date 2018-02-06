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
                        expressionNode: (nullable PSNode *) expressionNode {
    if (self = [super initWithToken: token]) {
        _type = type;
        _expressionNode = expressionNode;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSControlFlowTypes) type
                       expressionNode: (nullable PSNode *) expressionNode {
    return [self initWithToken: NULL type: type expressionNode: expressionNode];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, type: %@, node: %@>",
            NSStringFromClass([self class]), self.token, [PSControlFlowNode descriptionForType: self.type], self.expressionNode];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToControlFlowNode: (PSControlFlowNode *) object];
}

- (BOOL) isEqualToControlFlowNode: (PSControlFlowNode *) node {
    return node != NULL
        && self.type == node.type
        && ((!self.expressionNode && !node.expressionNode) || [self.expressionNode isEqual: node.expressionNode]);
}

@end
