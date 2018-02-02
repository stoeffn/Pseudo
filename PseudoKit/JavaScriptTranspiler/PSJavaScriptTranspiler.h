//
//  PSJavaScriptTranspiler.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSSyntaxNodeProgram.h"

@interface PSJavaScriptTranspiler : NSObject

@property (nonatomic) PSSyntaxNodeProgram *program;

- (instancetype) initWithProgram: (PSSyntaxNodeProgram *) program;

- (NSString *) code;

@end
