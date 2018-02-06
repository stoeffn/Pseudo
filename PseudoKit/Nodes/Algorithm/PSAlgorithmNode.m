//
//  PSAlgorithmNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSAlgorithmNode.h"

@implementation PSAlgorithmNode

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                        typeIdentifier: (nullable NSString *) typeIdentifier
                            identifier: (nonnull NSString *) identifier
                        parameterNodes: (nonnull NSArray<PSNode *> *) parameterNodes
                  returnTypeIdentifier: (nullable NSString *) returnTypeIdentifier
                              bodyNode: (nonnull PSNode *) bodyNode {
    if (self = [super initWithToken: token]) {
        _typeIdentifier = typeIdentifier;
        _identifier = identifier;
        _parameterNodes = parameterNodes;
        _returnTypeIdentifier = returnTypeIdentifier;
        _bodyNode = bodyNode;
    }
    return self;
}

- (nonnull instancetype) initWithTypeIdentifier: (nullable NSString *) typeIdentifier
                                     identifier: (nonnull NSString *) identifier
                                 parameterNodes: (nonnull NSArray<PSNode *> *) parameterNodes
                           returnTypeIdentifier: (nullable NSString *) returnTypeIdentifier
                                       bodyNode: (nonnull PSNode *) bodyNode {
    return [self initWithToken: NULL
                typeIdentifier: typeIdentifier
                    identifier: identifier
                parameterNodes: parameterNodes
          returnTypeIdentifier: returnTypeIdentifier
                      bodyNode: bodyNode];
}

#pragma mark - Description

- (nonnull NSString *) description {
    NSString *format = @"<%@ token: %@, typeIdentifier: %@, identifier: %@, parameterNodes: %@, returnTypeIdentifier: %@, body: %@>";
    return [[NSString alloc] initWithFormat: format, NSStringFromClass([self class]), self.token, self.typeIdentifier,
            self.identifier, self.parameterNodes, self.returnTypeIdentifier, self.bodyNode];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToAlgorithmNode: (PSAlgorithmNode *) object];
}

- (BOOL) isEqualToAlgorithmNode: (PSAlgorithmNode *) node {
    return node != NULL
        && ((!self.typeIdentifier && !node.typeIdentifier) || [self.typeIdentifier isEqualToString: node.typeIdentifier])
        && [self.identifier isEqual: node.identifier]
        && [self.parameterNodes isEqual: node.parameterNodes]
        && ((!self.typeIdentifier && !node.returnTypeIdentifier) || [self.typeIdentifier isEqualToString: node.returnTypeIdentifier])
        && [self.bodyNode isEqual: node.bodyNode];
}

@end
