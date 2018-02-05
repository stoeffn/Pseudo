//
//  PSUnaryOperationNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSUnaryOperationNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSUnaryOperationNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    switch (self.type) {
        case PSUnaryOperationTypesNot:
            return [[NSString alloc] initWithFormat: @"!%@", self.node.javaScriptCode];
        case PSUnaryOperationTypesNegation:
            return [[NSString alloc] initWithFormat: @"(-%@)", self.node.javaScriptCode];
    }
}

@end
