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
#import "PSNode.h"

@interface PSLexer : NSObject <PSLexing>

#pragma mark - Life Cycle

- (nonnull instancetype) init __unavailable;

- (nonnull instancetype) initWithReader: (nonnull id<PSReading>) reader;

#pragma mark - Expectations

- (nullable PSToken *) expectTokenTypes: (PSTokenTypes) tokenType
                                  error: (NSError * __nullable * __null_unspecified) error;

- (nullable PSToken *) expectOneOfTokenTypes: (nonnull NSSet<NSNumber *> *) tokenTypes
                                       error: (NSError * __nullable * __null_unspecified) error;

- (BOOL) expectMultipleOfTokenTypes: (nonnull NSSet<NSNumber *> *) tokenTypes
                            handler: (nonnull TokenHandler) handler
                              error: (NSError * __nullable * __null_unspecified) error;

@end
