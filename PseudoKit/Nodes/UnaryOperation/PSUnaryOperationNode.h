//
//  PSUnaryOperationNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"
#import "PSUnaryOperationTypes.h"

@interface PSUnaryOperationNode : PSNode

@property (nonatomic, readonly) PSUnaryOperationTypes type;

@property (nonatomic, readonly, nonnull) PSNode *node;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSUnaryOperationTypes) type
                                  node: (nonnull PSNode *) node;

- (nonnull instancetype) initWithType: (PSUnaryOperationTypes) type
                                 node: (nonnull PSNode *) node;

@end
