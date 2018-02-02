//
//  PSSyntaxNodeReturn+JavaScript.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNode+JavaScript.h"
#import "PSSyntaxNodeReturn+JavaScript.h"

@implementation PSSyntaxNodeReturn (JavaScript)

- (NSString *) javaScriptCode {
    NSString *code = [super javaScriptCode];
    return [[NSString alloc] initWithFormat: @"return %@\n;", code];
}

@end
