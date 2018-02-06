//
//  PSUnaryOperationNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSUnaryOperationNode.h"
#import "PSUnaryOperationNode+Types.h"

@implementation PSUnaryOperationNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSUnaryOperationTypes) type
                                  node: (nonnull PSNode *) node {
    if (self = [super initWithToken: token]) {
        _type = type;
        _node = node;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSUnaryOperationTypes) type
                                 node: (nonnull PSNode *) node {
    return [self initWithToken: NULL type: type node: node];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, type: %@, node: %@>",
            NSStringFromClass([self class]), self.token, [PSUnaryOperationNode descriptionForType: self.type], self.node];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToUnaryOperationNode: (PSUnaryOperationNode *) object];
}

- (BOOL) isEqualToUnaryOperationNode: (PSUnaryOperationNode *) node {
    return node != NULL
        && self.type == node.type
        && [self.node isEqual: node.node];
}

@end
