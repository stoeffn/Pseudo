//
//  PSConditionNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSConditionNode.h"

@implementation PSConditionNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                        expressionNode: (nonnull PSNode *) expressionNode
                              thenNode: (nonnull PSNode *) thenNode
                              elseNode: (nullable PSNode *) elseNode {
    if (self = [super initWithToken: token]) {
        _expressionNode = expressionNode;
        _thenNode = thenNode;
        _elseNode = elseNode;
    }
    return self;
}

- (nonnull instancetype) initWithExpressionNode: (nonnull PSNode *) expressionNode
                                       thenNode: (nonnull PSNode *) thenNode
                                       elseNode: (nullable PSNode *) elseNode {
    return [self initWithToken: NULL expressionNode: expressionNode thenNode: thenNode elseNode: elseNode];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, expression: %@, then: %@, else: %@>",
            NSStringFromClass([self class]), self.token, self.expressionNode, self.thenNode, self.elseNode];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToConditionNode: (PSConditionNode *) object];
}

- (BOOL) isEqualToConditionNode: (PSConditionNode *) node {
    return node != NULL
        && [self.expressionNode isEqual: node.expressionNode]
        && [self.thenNode isEqual: node.thenNode]
        && ((!self.elseNode && !node.elseNode) || [self.elseNode isEqual: node.elseNode]);
}

@end
