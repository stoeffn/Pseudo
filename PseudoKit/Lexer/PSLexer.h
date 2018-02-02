//
//  PSLexer.h
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSToken.h"

@interface PSLexer : NSObject

@property (nonatomic, readonly, copy, nonnull) NSString *code;

- (instancetype _Nonnull) initWithCode: (NSString * _Nonnull) code;

- (PSToken * _Nullable) nextToken;

- (void) reset;

@end
