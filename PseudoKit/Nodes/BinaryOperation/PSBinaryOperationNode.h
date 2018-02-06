//
//  PSBinaryOperationNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"
#import "PSBinaryOperationTypes.h"

@interface PSBinaryOperationNode : PSNode

@property (nonatomic, readonly) PSBinaryOperationTypes type;

@property (nonatomic, readonly, nonnull) PSNode *leftNode;

@property (nonatomic, readonly, nonnull) PSNode *rightNode;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSBinaryOperationTypes) type
                              leftNode: (nonnull PSNode *) leftNode
                             rightNode: (nonnull PSNode *) rightNode;

- (nonnull instancetype) initWithType: (PSBinaryOperationTypes) type
                             leftNode: (nonnull PSNode *) leftNode
                            rightNode: (nonnull PSNode *) rightNode;

@end
