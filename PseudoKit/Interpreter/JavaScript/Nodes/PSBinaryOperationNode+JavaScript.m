//
//  PSBinaryOperationNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSBinaryOperationNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSBinaryOperationNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    return [[NSString alloc] initWithFormat: @"(%@ %@ %@)", self.left.javaScriptCode, @"+", self.right.javaScriptCode];
}

@end
