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

- (nullable PSNode *) programWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

#pragma mark Blocks

- (nullable PSNode *) blockListWithStopTokenType: (nullable NSNumber *) stopTokenType
                                           error: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) blockWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

#pragma mark Statements

- (nullable PSNode *) statementListWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) statementWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

#pragma mark Conditions

- (nullable PSNode *) conditionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

#pragma mark Algorithms

- (nullable PSNode *) algorithmWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

#pragma mark Loops

- (nullable PSNode *) whileLoopWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) repeatLoopWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) forLoopWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

#pragma mark Expressions

- (nullable PSNode *) expressionWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) termWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) scalarWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

- (nullable PSNode *) literalWithError: (NSError * __nullable __autoreleasing * __null_unspecified) error;

@end
