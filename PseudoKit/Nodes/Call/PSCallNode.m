//
//  PSCallNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSCallNode.h"
#import "PSCallNode+Types.h"

@implementation PSCallNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSCallTypes) type
                           chainedNode: (nullable PSNode *) chainedNode
                            identifier: (nullable NSString *) identifier
                         argumentNodes: (nullable NSArray<PSNode *> *) argumentNodes {
    if (self = [super initWithToken: token]) {
        _type = type;
        _chainedNode = chainedNode;
        _identifier = identifier;
        _argumentNodes = argumentNodes;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSCallTypes) type
                          chainedNode: (nullable PSNode *) chainedNode
                           identifier: (nullable NSString *) identifier
                        argumentNodes: (nullable NSArray<PSNode *> *) argumentNodes {
    return [self initWithToken: NULL type: type chainedNode: chainedNode identifier: identifier argumentNodes: argumentNodes];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, type: %@, chainedNode: %@, identifier: %@, argumentNodes: %@>",
            NSStringFromClass([self class]), self.token, [PSCallNode descriptionForType: self.type], self.chainedNode,
            self.identifier, self.argumentNodes];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToCallNode: (PSCallNode *) object];
}

- (BOOL) isEqualToCallNode: (PSCallNode *) node {
    return node != NULL
        && self.type == node.type
        && ((!self.chainedNode && !node.chainedNode) || [self.chainedNode isEqualTo: node.chainedNode])
        && ((!self.identifier && !node.identifier) || [self.identifier isEqualTo: node.identifier])
        && ((!self.argumentNodes && !node.argumentNodes) || [self.argumentNodes isEqualTo: node.argumentNodes]);
}

@end
