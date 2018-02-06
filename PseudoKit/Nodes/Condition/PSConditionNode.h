//
//  PSConditionNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"

@interface PSConditionNode : PSNode

@property (nonatomic, readonly, nonnull) PSNode *expressionNode;

@property (nonatomic, readonly, nonnull) PSNode *thenNode;

@property (nonatomic, readonly, nullable) PSNode *elseNode;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                        expressionNode: (nonnull PSNode *) expressionNode
                              thenNode: (nonnull PSNode *) thenNode
                              elseNode: (nullable PSNode *) elseNode;

- (nonnull instancetype) initWithExpressionNode: (nonnull PSNode *) expressionNode
                                       thenNode: (nonnull PSNode *) thenNode
                                       elseNode: (nullable PSNode *) elseNode;

@end
