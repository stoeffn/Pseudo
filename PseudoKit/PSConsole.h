//
//  PSConsole.h
//  PseudoKit
//
//  Created by Steffen Ryll on 06.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSConsole : NSObject

#pragma mark - Life Cycle

- (nonnull instancetype) init __unavailable;

#pragma mark - Reading and Writing

+ (nullable NSString *) awaitString;

+ (nullable NSString *) awaitSanitizedString;

+ (void) writeString: (nonnull NSString *) string;

+ (void) writeErrorString: (nonnull NSString *) string;

@end
