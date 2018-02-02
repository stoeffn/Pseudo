//
//  PSSyntaxNodeKeyword.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSSyntaxNode.h"

@interface PSSyntaxNodeReturn : PSSyntaxNode

+ (PSSyntaxNodeReturn *) nextReturnSyntaxNodeFor: (NSMutableArray *) tokens;

@end