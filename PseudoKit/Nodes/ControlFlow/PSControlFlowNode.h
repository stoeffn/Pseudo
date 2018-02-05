//
//  PSControlFlowNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"
#import "PSControlFlowTypes.h"

@interface PSControlFlowNode : PSNode

@property (nonatomic, readonly) PSControlFlowTypes type;

@property (nonatomic, readonly, nullable) PSNode *node;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSControlFlowTypes) type
                                  node: (nullable PSNode *) node;

- (nonnull instancetype) initWithType: (PSControlFlowTypes) type
                                 node: (nullable PSNode *) node;

@end
