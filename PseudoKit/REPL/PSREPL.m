//
//  PSREPL.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSREPL.h"

@interface PSREPL ()

@property (nonatomic) BOOL isActive;

@end

@implementation PSREPL

#pragma mark - Life Cycle

- (nonnull instancetype) initWithInterpreter: (nonnull id<PSInterpreting>) interpreter {
    if (self = [super init]) {
        _interpreter = interpreter;
    }
    return self;
}

#pragma mark - Read–eval–print loop

- (void) enter {
    self.isActive = YES;

    while (self.isActive) {
        [self outputStringToCommandLine: @">>> "];

        NSString *input = [self stringFromCommandLineInput];
        if (!input) return [self leave];

        [self handleREPLInput: input];
    }
}

- (void) leave {
    [self outputStringToCommandLine: @"\n"];

    self.isActive = NO;
}

- (nullable NSString *) stringFromCommandLineInput {
    NSData *data = [NSFileHandle.fileHandleWithStandardInput availableData];
    if (!data.length) return NULL;

    return [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
}

- (void) outputStringToCommandLine: (NSString *) output {
    NSData *data = [output dataUsingEncoding: NSUTF8StringEncoding];
    [NSFileHandle.fileHandleWithStandardOutput writeData: data];
}

- (void) handleREPLInput: (NSString *) input {
    input = [input stringByTrimmingCharactersInSet: PSREPL.whitespaceAndNewLineAndControlCharacterSet];

    if (input.length == 0) return;

    NSError *error;
    NSString *result = [self.interpreter executePseudoCode: input error: &error];

    if (error) {
        [self outputStringToCommandLine: [[NSString alloc] initWithFormat: @"%@\n", error.localizedDescription]];
        return;
    }

    if (result && result.length > 0) {
        [self outputStringToCommandLine: [[NSString alloc] initWithFormat: @"%@\n", result]];
    }
}

#pragma mark - Constants

+ (nonnull NSCharacterSet *) whitespaceAndNewLineAndControlCharacterSet {
    static NSMutableCharacterSet *_delimiters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _delimiters = NSMutableCharacterSet.whitespaceAndNewlineCharacterSet;
        [_delimiters formUnionWithCharacterSet: NSMutableCharacterSet.controlCharacterSet];
        [_delimiters formUnionWithCharacterSet: NSMutableCharacterSet.illegalCharacterSet];
        [_delimiters addCharactersInString: @""]; // Characters produced by arrow keys.
    });
    return _delimiters;
}

@end
