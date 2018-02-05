//
//  PSLexer.h
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSReading.h"
#import "PSLexing.h"

@interface PSLexer : NSObject <PSLexing>

#pragma mark - Life Cycle

- (nonnull instancetype) init __unavailable;

- (nonnull instancetype) initWithReader: (nonnull id<PSReading>) reader;

@end
