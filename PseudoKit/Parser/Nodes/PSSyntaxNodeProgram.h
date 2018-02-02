//
//  PSSyntaxNodeProgram.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSToken.h"
#import "PSSyntaxNode.h"

@interface PSSyntaxNodeProgram : PSSyntaxNode

+ (PSSyntaxNodeProgram *) nextProgramSyntaxNodeFor: (NSMutableArray<PSToken *> *) tokens;

@end