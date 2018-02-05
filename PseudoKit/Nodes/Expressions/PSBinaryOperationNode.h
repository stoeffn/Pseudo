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

@property (nonatomic, readonly, nonnull) PSNode *left;

@property (nonatomic, readonly, nonnull) PSNode *right;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSBinaryOperationTypes) type
                                  left: (nonnull PSNode *) left
                                 right: (nonnull PSNode *) right;

- (nonnull instancetype) initWithType: (PSBinaryOperationTypes) type
                                 left: (nonnull PSNode *) left
                                right: (nonnull PSNode *) right;

- (nullable instancetype) initWithToken: (nonnull PSToken *) token
                                   left: (nonnull PSNode *) left
                                  right: (nonnull PSNode *) right;

@end
