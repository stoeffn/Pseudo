//
//  PSBinaryOperationNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSBinaryOperationNode.h"

@implementation PSBinaryOperationNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  left: (nonnull PSNode *) left
                                 right: (nonnull PSNode *) right {
    if (self = [super initWithToken: token]) {
        _left = left;
        _right = right;
    }
    return self;
}

- (nonnull instancetype) initWithLeft: (nonnull PSNode *) left
                                right: (nonnull PSNode *) right {
    return [self initWithToken: NULL left: left right: right];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, left: %@, right: %@>",
            NSStringFromClass([self class]), self.token, self.left, self.right];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToBinaryOperationNode: (PSBinaryOperationNode *) object];
}

- (BOOL) isEqualToBinaryOperationNode: (PSBinaryOperationNode *) node {
    return node != NULL
        && ((!self.left && !node.left) || [self.left isEqual: node.left])
        && ((!self.right && !node.right) || [self.right isEqual: node.right]);
}

@end
