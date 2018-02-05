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
        NSString *code = @"1 + 1";

        PSStringReader *reader = [[PSStringReader alloc] initWithString: code];
        PSLexer *lexer = [[PSLexer alloc] initWithReader: reader];
        PSParser *parser = [[PSParser alloc] initWithLexer: lexer];

        NSError *error;
        PSNode *node = [parser expressionWithError: &error];

        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            return (int) error.code;
        }

        PSJavaScriptTranspiler *javaScriptTranspiler = [[PSJavaScriptTranspiler alloc] initWithNode: node];
        JSContext *context = [[JSContext alloc] init];
        JSValue *value = [context evaluateScript: javaScriptTranspiler.code];
        NSLog(@">>> %@", value);
    }
    return 0;
}
