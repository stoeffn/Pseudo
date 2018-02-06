//
//  PSBinaryOperationNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSBinaryOperationNode.h"
#import "PSBinaryOperationNode+Types.h"

@implementation PSBinaryOperationNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSBinaryOperationTypes) type
                                  leftNode: (nonnull PSNode *) leftNode
                                 rightNode: (nonnull PSNode *) rightNode {
    if (self = [super initWithToken: token]) {
        _type = type;
        _leftNode = leftNode;
        _rightNode = rightNode;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSBinaryOperationTypes) type
                                 leftNode: (nonnull PSNode *) leftNode
                                rightNode: (nonnull PSNode *) rightNode {
    return [self initWithToken: NULL type: type leftNode: leftNode rightNode: rightNode];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, type: %@, left: %@, right: %@>",
            NSStringFromClass([self class]), self.token, [PSBinaryOperationNode descriptionForType: self.type], self.leftNode,
            self.rightNode];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToBinaryOperationNode: (PSBinaryOperationNode *) object];
}

- (BOOL) isEqualToBinaryOperationNode: (PSBinaryOperationNode *) node {
    return node != NULL
        && self.type == node.type
        && [self.leftNode isEqual: node.leftNode]
        && [self.rightNode isEqual: node.rightNode];
}

@end
