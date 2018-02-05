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
                                  left: (nonnull PSNode *) left
                                 right: (nonnull PSNode *) right {
    if (self = [super initWithToken: token]) {
        _type = type;
        _left = left;
        _right = right;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSBinaryOperationTypes) type
                                 left: (nonnull PSNode *) left
                                right: (nonnull PSNode *) right {
    return [self initWithToken: NULL type: type left: left right: right];
}

- (nullable instancetype) initWithToken: (nonnull PSToken *) token
                                   left: (nonnull PSNode *) left
                                  right: (nonnull PSNode *) right {
    NSNumber *type = [PSBinaryOperationNode typeForTokenType: token.type];
    if (!type) return NULL;

    return [self initWithToken: token type: type.integerValue left: left right: right];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, type: %@, left: %@, right: %@>",
            NSStringFromClass([self class]), self.token, [PSBinaryOperationNode descriptionForType: self.type], self.left,
            self.right];
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