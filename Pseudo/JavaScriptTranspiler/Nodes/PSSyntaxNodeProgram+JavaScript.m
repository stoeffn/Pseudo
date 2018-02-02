//
//  PSSyntaxNodeProgram+JavaScript.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNodeProgram+JavaScript.h"
#import "PSSyntaxNode+JavaScript.h"

@implementation PSSyntaxNodeProgram (JavaScript)

- (NSString *) javaScriptCode {
    NSString *code = [super javaScriptCode];
    return [[NSString alloc] initWithFormat: @"%@\n", code];
}

@end
