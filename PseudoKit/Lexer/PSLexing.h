//
//  PSLexing.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSToken.h"

typedef void (^TokenHandler)(PSToken *_Nonnull);

@protocol PSLexing <NSObject>

#pragma mark - State

@property (nonatomic, readonly, nullable) PSToken *currentToken;

@property (nonatomic, readonly, nullable) PSToken *nextToken;

#pragma mark - Advancing

- (nullable PSToken *) advance;

#pragma mark - Expectations

- (nullable PSToken *) expectTokenTypes: (PSTokenTypes) tokenType
                                  error: (NSError * __nullable * __null_unspecified) error;

- (nullable PSToken *) expectOneOfTokenTypes: (nonnull NSSet<NSNumber *> *) tokenTypes
                                       error: (NSError * __nullable * __null_unspecified) error;

- (BOOL) expectMultipleOfTokenTypes: (nonnull NSSet<NSNumber *> *) tokenTypes
                            handler: (nonnull TokenHandler) handler
                              error: (NSError * __nullable * __null_unspecified) error;

@end
