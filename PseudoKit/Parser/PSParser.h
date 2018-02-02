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

@interface PSParser : NSObject

@property (nonatomic, nonnull) PSLexer *lexer;

- (instancetype _Nonnull) init __unavailable;

- (nonnull instancetype) initWithLexer: (nonnull PSLexer *) lexer;

- (nonnull PSSyntaxNodeProgram *) programWithError: (NSError * __nullable * __null_unspecified) error;

@end
