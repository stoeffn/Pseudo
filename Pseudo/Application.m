//
//  Application.m
//  Pseudo
//
//  Created by Steffen Ryll on 06.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "Application.h"
#import "PseudoKit.h"

@interface Application ()

@property (nonatomic, readonly, nonnull) id<PSInterpreting> interpreter;

@property (nonatomic, readonly, nonnull) PSREPL *repl;

@end

@implementation Application

#pragma mark - Life Cycle

- (nonnull instancetype) init {
    if (self = [super init]) {
        _interpreter = [[PSJavaScriptInterpreter alloc] init];
        _repl = [[PSREPL alloc] initWithInterpreter: _interpreter];
    }
    return self;
}

- (BOOL) executeWithArguments: (nonnull NSArray<NSString *> *) arguments {
    if (arguments.count <= 1) {
        return [self enterREPL];
    }

    if ([arguments[1] isEqualToString: @"-h"]) {
        return [self printHelp];
    }

    if ([arguments[1] isEqualToString: @"-i"]) {
        [self executeFilesAtFilePaths: [arguments subarrayWithRange: NSMakeRange(2, arguments.count - 2)]];
        return [self enterREPL];
    }

    if ([arguments[1] hasPrefix: @"-"]) {
        return [self printInvalidArgumentsError];
    }

    return [self executeFilesAtFilePaths: [arguments subarrayWithRange: NSMakeRange(1, arguments.count - 1)]];
}

#pragma mark - Commands

- (BOOL) executeFilesAtFilePaths: (NSArray<NSString *> *) filePaths {
    __block NSError *error;

    [filePaths enumerateObjectsUsingBlock: ^(NSString * _Nonnull filePath, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![filePath hasSuffix: PSDefaultFileExtension]) {
            filePath = [filePath stringByAppendingString: PSDefaultFileExtension];
        }

        NSString *code = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
        if (error) *stop = YES;

        [self.interpreter executePseudoCode: code error: &error];
        if (error) *stop = YES;
    }];

    if (error) {
        [PSConsole writeErrorString: [[NSString alloc] initWithFormat: @"%@\n", error.localizedDescription]];
        return NO;
    }

    return YES;
}

- (BOOL) enterREPL {
    [self.repl enter];
    return YES;
}

- (BOOL) printHelp {
    [PSConsole writeString: @"Usage: pseudo [-i | -h] file...\n"
                             "-i      : Starts interactive REPL after executing files\n"
                             "-h      : Prints this help message and exits\n"
                             "file... : Executes zero or more files; implicitly starts interactive REPL if no files are given\n"];
    return YES;
}

- (BOOL) printInvalidArgumentsError {
    [PSConsole writeString: @"Invalid arguments. Type \"pseudo -h\" for help.\n"];
    return NO;
}

@end
