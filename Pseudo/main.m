//
//  main.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "PSLexer.h"
#import "PSParser.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        JSContext *context = [[JSContext alloc] init];
        JSValue *value = [context evaluateScript: @"21 + 21"];
        NSLog(@"%@", value);

        NSString *code = @"algorithm main():"
                          "    return 42.";
        PSLexer *lexer = [[PSLexer alloc] initWithCode: code];
        PSParser *parser = [[PSParser alloc] initWithTokens: lexer.tokens];
        NSLog(@"%@", parser.description);
    }
    return 0;
}
