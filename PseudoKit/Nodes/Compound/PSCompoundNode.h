//
//  PSCompoundNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"

@interface PSCompoundNode : PSNode

@property (nonatomic, readonly, nonnull) NSArray<PSNode *> *nodes;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                 nodes: (nonnull NSArray<PSNode *> *) nodes;

- (nonnull instancetype) initWithNodes: (nonnull NSArray<PSNode *> *) nodes;

@end
