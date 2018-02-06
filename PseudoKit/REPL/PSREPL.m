//
//  PSREPL.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSREPL.h"
#import "PSConsole.h"

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
        [PSConsole writeString: @">>> "];

        NSString *input = [PSConsole awaitSanitizedString];
        if (!input) return [self leave];

        [self handleREPLInput: input];
    }
}

- (void) leave {
    [PSConsole writeString: @"\n"];

    self.isActive = NO;
}

- (void) handleREPLInput: (NSString *) input {
    if (input.length == 0) return;

    NSError *error;
    NSString *result = [self.interpreter executePseudoCode: input error: &error];

    if (error) {
        [PSConsole writeString: [[NSString alloc] initWithFormat: @"%@\n", error.localizedDescription]];
        return;
    }

    if (result && result.length > 0) {
        [PSConsole writeString: [[NSString alloc] initWithFormat: @"%@\n", result]];
    }
}

@end
