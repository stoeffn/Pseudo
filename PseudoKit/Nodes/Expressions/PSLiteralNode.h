//
//  PSLiteralNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 03.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"

@interface PSLiteralNode : PSNode

@property (nonatomic, readonly, nonnull) NSNumber *value;

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                 value: (nonnull NSNumber *) value;

- (nonnull instancetype) initWithValue: (nonnull NSNumber *) value;

@end
