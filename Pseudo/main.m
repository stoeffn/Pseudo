//
//  main.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "PseudoKit.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSString *code = @"algorithm main():"
                          "    .";

        PSLexer *lexer = [[PSLexer alloc] initWithCode: code];
        PSParser *parser = [[PSParser alloc] initWithLexer: lexer];

        NSError *error;
        PSSyntaxNodeProgram *program = [parser programWithError: &error];

        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            return (int) error.code;
        }

        PSJavaScriptTranspiler *javaScriptTranspiler = [[PSJavaScriptTranspiler alloc] initWithProgram: program];
        JSContext *context = [[JSContext alloc] init];
        [context evaluateScript: javaScriptTranspiler.code];
        JSValue *value = [context evaluateScript: @"main();"];
        NSLog(@"Return value of 'main': %@", value);
    }
    return 0;
}
