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
        printf(">>> ");

        NSData *data = [[NSFileHandle fileHandleWithStandardInput] availableData];
        NSString *string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        [self handleREPLInput: string];
    }
}

- (void) leave {
    self.isActive = NO;
}

- (void) handleREPLInput: (NSString *) input {
    NSError *error;
    NSString *result = [self.interpreter executePseudoCode: input error: &error];

    if (error) printf("%s\n", [error.localizedDescription UTF8String]);
    if (result.length > 0) printf("%s\n", [result UTF8String]);
}

@end
