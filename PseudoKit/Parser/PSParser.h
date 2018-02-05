//
//  PSParser.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSLexing.h"
#import "PSNode.h"

@interface PSParser : NSObject

@property (nonatomic, nonnull) id<PSLexing> lexer;

#pragma mark - Life Cycle

- (instancetype _Nonnull) init __unavailable;

- (nonnull instancetype) initWithLexer: (nonnull id<PSLexing>) lexer;

#pragma mark - Parsing

- (nullable PSNode *) expressionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) termWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) scalarWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) literalWithError: (NSError * __nullable * __null_unspecified) error;

@end
