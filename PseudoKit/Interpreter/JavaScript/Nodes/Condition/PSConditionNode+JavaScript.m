//
//  PSConditionNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSConditionNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSConditionNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    if (!self.elseNode) {
        return [[NSString alloc] initWithFormat: @"if %@ { %@ }",
                self.expressionNode.javaScriptCode, self.thenNode.javaScriptCode];
    }

    return [[NSString alloc] initWithFormat: @"if %@ { %@ } else { %@ }",
            self.expressionNode.javaScriptCode, self.thenNode.javaScriptCode, self.elseNode.javaScriptCode];
}

@end
