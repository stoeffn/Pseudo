//
//  main.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PseudoKit.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        PSREPL *repl = [[PSREPL alloc] initWithInterpreter: [[PSJavaScriptInterpreter alloc] init]];
        [repl enter];
    }
    return 0;
}
