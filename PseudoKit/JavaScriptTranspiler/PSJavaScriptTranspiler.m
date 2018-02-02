//
//  PSJavaScriptTranspiler.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSJavaScriptTranspiler.h"
#import "PSSyntaxNodeProgram+JavaScript.h"

@implementation PSJavaScriptTranspiler

- (instancetype) initWithProgram: (PSSyntaxNodeProgram *) program {
    if (self = [super init]) {
        _program = program;
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ program: %@, code: %@>",
            NSStringFromClass([self class]), self.program, self.code];
}

- (NSString *) code {
    return self.program.javaScriptCode;
}

@end
