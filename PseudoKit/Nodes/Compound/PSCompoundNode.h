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

@property (nonatomic, readonly, nonnull) NSArray<PSNode *> *children;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                              children: (nonnull NSArray<PSNode *> *) children;

- (nonnull instancetype) initWithChildren: (nonnull NSArray<PSNode *> *) children;

@end
