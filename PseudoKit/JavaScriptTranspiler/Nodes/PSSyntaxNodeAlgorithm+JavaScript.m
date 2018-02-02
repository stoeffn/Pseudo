//
//  PSSyntaxNodeAlgorithm+JavaScript.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNode+JavaScript.h"
#import "PSSyntaxNodeAlgorithm+JavaScript.h"
#import "PSSyntaxNodeAlgorithm.h"

@implementation PSSyntaxNodeAlgorithm (JavaScript)

- (NSString *) javaScriptCode {
    NSString *code = [super javaScriptCode];
    return [[NSString alloc] initWithFormat:
            @"function %@(){\n"
            "%@"
            "}\n\n",
            self.identifier, code];
}

@end
