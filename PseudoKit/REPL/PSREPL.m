//
//  PSREPL.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSREPL.h"
#import "PSConsole.h"
#import "PSParser+Errors.h"

@interface PSREPL ()

@property (nonatomic) BOOL isActive;

@property (nonatomic, nonnull) NSMutableArray<NSString *> *buffer;

@end

@implementation PSREPL

#pragma mark - Life Cycle

- (nonnull instancetype) initWithInterpreter: (nonnull id<PSInterpreting>) interpreter {
    if (self = [super init]) {
        _interpreter = interpreter;
        _isActive = NO;
        _buffer = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Read–eval–print loop

- (void) enter {
    self.isActive = YES;

    while (self.isActive) {
        [self promptForInput];
        NSString *input = [PSConsole awaitSanitizedString];
        if (!input) return [self leave];

        [self handleREPLInput: input];
    }
}

- (void) leave {
    [PSConsole writeString: @"\n"];

    self.isActive = NO;
}

- (void) handleREPLInput: (nonnull NSString *) input {
    if (input.length == 0) return;

    [self.buffer addObject: input];

    NSString *code = [self.buffer componentsJoinedByString: @"\n"];

    NSError *error;
    NSString *result = [self.interpreter executePseudoCode: code error: &error];

    if (error && [error.domain isEqualToString: PSParserErrorDomain] && error.code == PSParserErrorTypesEndOfFile) {
        return;
    }

    [self.buffer removeAllObjects];

    if (error) {
        [PSConsole writeString: [[NSString alloc] initWithFormat: @"%@\n", error.localizedDescription]];
        return;
    }

    if (result && result.length > 0) {
        [PSConsole writeString: [[NSString alloc] initWithFormat: @"%@\n", result]];
    }
}

- (void) promptForInput {
    if (self.buffer.count == 0) {
        [PSConsole writeString: @">>> "];
    } else {
        [PSConsole writeString: @"... "];
    }
}

@end
