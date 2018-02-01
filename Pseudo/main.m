//
//  main.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSLexer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *code = @"algorithm main():"
                          "    return 42.";
        PSLexer *lexer = [[PSLexer alloc] initWithCode: code];
        NSLog(@"%@", lexer.description);
    }
    return 0;
}
