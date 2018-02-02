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

- (instancetype _Nonnull) init __unavailable;

- (instancetype _Nonnull) initWithCode: (nonnull NSString *) code;

- (PSToken * _Nullable) nextToken;

- (PSToken * _Nullable) expectTokenType: (PSTokenType) tokenType error: (NSError * __nullable * __null_unspecified) error;

- (void) reset;

@end
