//
//  PSParser.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSLexer.h"
#import "PSSyntaxNodeProgram.h"
#import "PSSyntaxNodeAlgorithm.h"

@interface PSParser : NSObject

@property (nonatomic, nonnull) PSLexer *lexer;

- (instancetype _Nonnull) init __unavailable;

- (nonnull instancetype) initWithLexer: (nonnull PSLexer *) lexer;

- (nullable PSSyntaxNodeProgram *) programWithError: (NSError * __nullable * __null_unspecified) error;

- (nullable PSSyntaxNodeAlgorithm *) algorithmWithError: (NSError * __nullable * __null_unspecified) error;

@end
