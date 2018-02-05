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
    NSMutableArray<NSString *> *code = [NSMutableArray arrayWithCapacity: self.children.count];
    [self.children enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        [code addObject: ((PSNode *) obj).javaScriptCode];
    }];
    return [code componentsJoinedByString: @";"];
}

@end
