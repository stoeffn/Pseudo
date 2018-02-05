//
//  PSLiteralNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 03.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"
#import "PSLiteralTypes.h"

@interface PSLiteralNode : PSNode

# pragma mark - State

@property (nonatomic, readonly) PSLiteralTypes type;

@property (nonatomic, readonly, copy, nullable) NSString *string;

@property (nonatomic, readonly, nullable) NSNumber *number;

# pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSLiteralTypes) type
                                string: (nullable NSString *) string
                                number: (nullable NSNumber *) number;

- (nonnull instancetype) initWithType: (PSLiteralTypes) type
                               string: (nullable NSString *) string
                               number: (nullable NSNumber *) number;

- (nonnull instancetype) initWithType: (PSLiteralTypes) type;

- (nonnull instancetype) initWithString: (nullable NSString *) string;

- (nonnull instancetype) initWithNumber: (nullable NSNumber *) number;

@end
