//
//  PSNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSToken.h"

@interface PSNode : NSObject

@property (nonatomic, readonly, nullable) PSToken *token;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token;

@end
