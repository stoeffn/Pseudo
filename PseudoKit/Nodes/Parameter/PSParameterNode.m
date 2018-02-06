//
//  PSParameterNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSParameterNode.h"

@implementation PSParameterNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                        typeIdentifier: (nonnull NSString *) typeIdentifier
                            identifier: (nonnull NSString *) identifier {
    if (self = [super initWithToken: token]) {
        _typeIdentifier = typeIdentifier;
        _identifier = identifier;
    }
    return self;
}

- (nonnull instancetype) initWithTypeIdentifier: (nonnull NSString *) typeIdentifier
                                     identifier: (nonnull NSString *) identifier {
    return [self initWithToken: NULL typeIdentifier: typeIdentifier identifier: identifier];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, typeIdentifier: %@, identifier: %@>",
            NSStringFromClass([self class]), self.token, self.typeIdentifier, self.identifier];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToParameterNode: (PSParameterNode *) object];
}

- (BOOL) isEqualToParameterNode: (PSParameterNode *) node {
    return node != NULL
        && [self.typeIdentifier isEqual: node.typeIdentifier]
        && [self.identifier isEqual: node.identifier];
}

@end
