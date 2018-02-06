//
//  PSControlFlowNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSControlFlowNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSControlFlowNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    switch (self.type) {
        case PSControlFlowTypesBreak:
            return @"break";
        case PSControlFlowTypesContinue:
            return @"continue";
        case PSControlFlowTypesReturn:
            if (!self.expressionNode) return @"return";
            return [[NSString alloc] initWithFormat: @"return %@", self.expressionNode.javaScriptCode];
    }
}

@end
