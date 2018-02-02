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

@property (nonatomic, readonly) PSTokenType type;

@property (nonatomic, readonly, copy, nullable) NSString *value;

- (instancetype _Nonnull) init __unavailable;

- (instancetype _Nonnull) initWithType: (PSTokenType) type andValue: (NSString * _Nullable) value;

- (instancetype _Nullable) initWithRawToken: (NSString * _Nullable) rawToken;

@end
