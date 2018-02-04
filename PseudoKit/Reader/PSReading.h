//
//  PSReading.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSReading <NSObject>

#pragma mark - State

@property (nonatomic, readonly, copy, nullable) NSString *currentCharacter;

@property (nonatomic, readonly, copy, nullable) NSString *nextCharacter;

#pragma mark - Advancing

- (nullable NSString *) advance;

@end
