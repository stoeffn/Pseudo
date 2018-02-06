//
//  PSCompoundNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSCompoundNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSCompoundNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    NSMutableArray<NSString *> *code = [NSMutableArray arrayWithCapacity: self.nodes.count];
    [self.nodes enumerateObjectsUsingBlock: ^(PSNode *node, NSUInteger idx, BOOL *stop) {
        [code addObject: node.javaScriptCode];
    }];
    return [code componentsJoinedByString: @"; "];
}

@end
