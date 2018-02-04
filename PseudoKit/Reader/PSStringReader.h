//
//  PSStringReader.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSReading.h"

@interface PSStringReader : NSObject <PSReading>

#pragma mark - State

@property (nonatomic, readonly, copy, nonnull) NSString *string;

#pragma mark - Life Cycle

- (nonnull instancetype) init __unavailable;

- (nonnull instancetype) initWithString: (nonnull NSString *) string;

@end
