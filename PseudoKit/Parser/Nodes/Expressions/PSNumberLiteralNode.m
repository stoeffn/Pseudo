//
//  PSNumberLiteralNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 03.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSNumberLiteralNode.h"

@implementation PSNumberLiteralNode

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                 value: (nonnull NSNumber *) value {
    if (self = [super initWithToken: token]) {
        _value = value;
    }
    return self;
}

- (nonnull instancetype) initWithValue: (nonnull NSNumber *) value {
    return [self initWithToken: NULL value: value];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, value: %@>",
            NSStringFromClass([self class]), self.token, self.value];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToNumberLiteralNode: (PSNumberLiteralNode *) object];
}

- (BOOL) isEqualToNumberLiteralNode: (PSNumberLiteralNode *) node {
    return node != NULL
        && ((!self.value && !node.value) || [self.value isEqual: node.value]);
}

@end
