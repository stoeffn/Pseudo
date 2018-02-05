//
//  PSREPL.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSInterpreting.h"

@interface PSREPL : NSObject

#pragma mark - State

@property (nonatomic, readonly, nonnull) id<PSInterpreting> interpreter;

#pragma mark - Life Cycle

- (nonnull instancetype) init __unavailable;

- (nonnull instancetype) initWithInterpreter: (nonnull id<PSInterpreting>) interpreter;

#pragma mark - Read–eval–print loop

- (void) enter;

- (void) leave;

@end
