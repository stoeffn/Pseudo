//
//  PSJavaScriptInterpreter.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "PSJavaScriptInterpreter.h"
#import "PSStringReader.h"
#import "PSLexer.h"
#import "PSParser.h"
#import "PSNode+JavaScript.h"

@interface PSJavaScriptInterpreter ()

@property (nonatomic, nonnull) JSContext *context;

@end

@implementation PSJavaScriptInterpreter

#pragma mark - Life Cycle

- (nonnull instancetype) init {
    if (self = [super init]) {
        _context = [[JSContext alloc] init];
    }
    return self;
}

#pragma mark - Executing Code

- (nullable NSString *) executeNode: (nonnull PSNode *) node {
    return [self.context evaluateScript: node.javaScriptCode].description;
}

- (nullable NSString *) executePseudoCode: (nonnull NSString *) code
                                    error: (NSError * __nullable __autoreleasing * __null_unspecified) error {
    PSStringReader *reader = [[PSStringReader alloc] initWithString: code];
    PSLexer *lexer = [[PSLexer alloc] initWithReader: reader];
    PSParser *parser = [[PSParser alloc] initWithLexer: lexer];
    PSNode *node = [parser expressionWithError: error];

    if (*error) return NULL;
    return [self executeNode: node];
}

@end
