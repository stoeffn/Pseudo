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

@end

@implementation Application

#pragma mark - Life Cycle

- (nonnull instancetype) init {
    if (self = [super init]) {
        _interpreter = [[PSJavaScriptInterpreter alloc] init];
    }
    return self;
}

- (BOOL) executeWithArguments: (nonnull NSArray<NSString *> *) arguments {
    PSREPL *repl = [[PSREPL alloc] initWithInterpreter: self.interpreter];
    [repl enter];

    return YES;
}

@end
