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

- (nonnull instancetype) init __unavailable;

- (nonnull instancetype) initWithCode: (nonnull NSString *) code;

- (nullable PSToken *) nextToken;

- (nullable PSToken *) expectTokenType: (PSTokenType) tokenType error: (NSError * __nullable * __null_unspecified) error;

- (void) reset;

@end
