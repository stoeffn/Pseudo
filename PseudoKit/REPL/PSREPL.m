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

        [self setUpNativeAlgorithms];
    }
    return self;
}

#pragma mark - Read–eval–print loop

- (void) enter {
    self.isActive = YES;

    [self printWelcomeMessage];

    while (self.isActive) {
        [self promptForInput];
        [self handleREPLInput: [PSConsole awaitSanitizedString]];
    }
}

- (void) leave {
    self.isActive = NO;
}

- (void) printWelcomeMessage {
    NSString *version = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
    NSString *build = NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"];
    NSString *welcomeMessage = [[NSString alloc] initWithFormat: @"Pseudo %@ (Build %@)\n"
                                                                  "Type \"help()\" for more information.\n", version, build];
    [PSConsole writeString: welcomeMessage];
}

- (void) printHelpMessage {
    NSString *helpMessage =
    @"Pseudo is a pseudo-language you can actually execute!\n"
    "This REPL supports multi-line input. Use [CTRL] + [D] to exit multi-line-input or the REPL.\n"
    "\n"
    "NATIVE ALGORITHMS:\n"
    "print(Obj): Prints the object given to standard output\n"
    "input():    String: Reads one line of text from standard input\n"
    "exit():     Exits this REPL\n";
    [PSConsole writeString: helpMessage];
}

- (void) promptForInput {
    if (self.buffer.count == 0) {
        [PSConsole writeString: @">>> "];
    } else {
        [PSConsole writeString: @"... "];
    }
}

- (void) handleREPLInput: (NSString *) input {
    if (!input && self.buffer.count > 0) {
        [self.buffer removeAllObjects];
        return [PSConsole writeString: @"\n"];
    }

    if (!input) {
        [self leave];
        return [PSConsole writeString: @"\n"];
    }

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
        return [PSConsole writeString: [[NSString alloc] initWithFormat: @"%@\n", error.localizedDescription]];
    }

    if (result && result.length > 0) {
        [PSConsole writeString: [[NSString alloc] initWithFormat: @"%@\n", result]];
    }
}

#pragma mark - Providing Native Algorithms

- (void) setUpNativeAlgorithms {
    __weak PSREPL *weakSelf = self;

    self.interpreter[@"print"] = ^(NSString *string) {
        [PSConsole writeString: [[NSString alloc] initWithFormat: @"%@\n", string]];
    };
    self.interpreter[@"input"] = ^NSString *() {
        return [PSConsole awaitSanitizedString];
    };
    self.interpreter[@"help"] = ^void() {
        [weakSelf printHelpMessage];
    };
    self.interpreter[@"exit"] = ^void() {
        [weakSelf leave];
    };
}

@end
