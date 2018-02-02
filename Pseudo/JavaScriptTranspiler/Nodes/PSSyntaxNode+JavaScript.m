//
//  PSSyntaxNode+JavaScript.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNode+JavaScript.h"

@implementation PSSyntaxNode (JavaScript)

- (NSString *) javaScriptCode {
    NSMutableString *code = [[NSMutableString alloc] init];

    for (PSSyntaxNode *node in self.children) {
        [code appendFormat: @"%@\n", node.javaScriptCode];
    }

    return code;
}

@end
