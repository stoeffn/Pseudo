//
//  PSParser.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSToken.h"
#import "PSSyntaxNodeProgram.h"

@interface PSParser : NSObject

@property (nonatomic) NSArray<PSToken *> *tokens;

- (instancetype) initWithTokens: (NSArray<PSToken *> *) tokens;

- (PSSyntaxNodeProgram *) program;

@end
