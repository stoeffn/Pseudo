//
//  PSAlgorithmNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"

@interface PSAlgorithmNode : PSNode

@property (nonatomic, readonly, copy, nullable) NSString *typeIdentifier;

@property (nonatomic, readonly, copy, nonnull) NSString *identifier;

@property (nonatomic, readonly, nonnull) NSArray<PSNode *> *parameterNodes;

@property (nonatomic, readonly, copy, nullable) NSString *returnTypeIdentifier;

@property (nonatomic, readonly, nonnull) PSNode *bodyNode;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                        typeIdentifier: (nullable NSString *) typeIdentifier
                            identifier: (nonnull NSString *) identifier
                        parameterNodes: (nonnull NSArray<PSNode *> *) parameterNodes
                  returnTypeIdentifier: (nullable NSString *) returnTypeIdentifier
                              bodyNode: (nonnull PSNode *) bodyNode;

- (nonnull instancetype) initWithTypeIdentifier: (nullable NSString *) typeIdentifier
                                     identifier: (nonnull NSString *) identifier
                                 parameterNodes: (nonnull NSArray<PSNode *> *) parameterNodes
                           returnTypeIdentifier: (nullable NSString *) returnTypeIdentifier
                                       bodyNode: (nonnull PSNode *) bodyNode;

@end
