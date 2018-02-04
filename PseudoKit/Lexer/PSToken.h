//
//  PSToken.h
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSTokenType.h"

@interface PSToken : NSObject

#pragma mark - Properties

@property (nonatomic, readonly) PSTokenType type;

@property (nonatomic, readonly, copy, nullable) NSString *string;

@property (nonatomic, readonly, nullable) NSNumber *number;

#pragma mark - Life Cycle

- (nonnull instancetype) init __unavailable;

- (nonnull instancetype) initWithType: (PSTokenType) type
                               number: (nullable NSNumber *) number;

- (nonnull instancetype) initWithType: (PSTokenType) type
                               string: (nullable NSString *) string;

- (nonnull instancetype) initWithType: (PSTokenType) type;

- (nonnull instancetype) initWithRawToken: (nullable NSString *) rawToken;

@end
