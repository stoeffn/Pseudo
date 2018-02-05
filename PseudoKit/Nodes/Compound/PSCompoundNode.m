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
                              children: (nonnull NSArray<PSNode *> *) children {
    if (self = [super initWithToken: token]) {
        _children = children;
    }
    return self;
}

- (nonnull instancetype) initWithChildren: (nonnull NSArray<PSNode *> *) children {
    return [self initWithToken: NULL children: children];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, children: %@>",
            NSStringFromClass([self class]), self.token, self.children];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToCompoundNode: (PSCompoundNode *) object];
}

- (BOOL) isEqualToCompoundNode: (PSCompoundNode *) node {
    return node != NULL
        && [self.children isEqual: node.children];
}

@end
