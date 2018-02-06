//
//  PSCallNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"
#import "PSCallTypes.h"

@interface PSCallNode : PSNode

@property (nonatomic, readonly) PSCallTypes type;

@property (nonatomic, readonly, nullable) PSNode *chainedNode;

@property (nonatomic, readonly, copy, nullable) NSString *identifier;

@property (nonatomic, readonly, nullable) NSArray<PSNode *> *argumentNodes;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSCallTypes) type
                           chainedNode: (nullable PSNode *) chainedNode
                            identifier: (nullable NSString *) identifier
                         argumentNodes: (nullable NSArray<PSNode *> *) argumentNodes;

- (nonnull instancetype) initWithType: (PSCallTypes) type
                          chainedNode: (nullable PSNode *) chainedNode
                           identifier: (nullable NSString *) identifier
                        argumentNodes: (nullable NSArray<PSNode *> *) argumentNodes;

@end
