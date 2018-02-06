//
//  PSCallNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSCallNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSCallNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    switch (self.type) {
        case PSCallTypesVariable:
            return self.identifier;
        case PSCallTypesFunction:
            return [[NSString alloc] initWithFormat: @"%@(%@)", self.identifier, self.javaScriptCodeForArguments];
        case PSCallTypesSubscript:
            return [[NSString alloc] initWithFormat: @"[%@]", self.javaScriptCodeForArguments];
        case PSCallTypesConstructor:
            return [[NSString alloc] initWithFormat: @"new %@(%@)", self.identifier, self.javaScriptCodeForArguments];
    }
}

- (nullable NSString *) javaScriptCodeForArguments {
    if (!self.argumentNodes) return NULL;

    NSMutableArray<NSString *> *code = [NSMutableArray arrayWithCapacity: self.argumentNodes.count];
    [self.argumentNodes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        [code addObject: ((PSNode *) obj).javaScriptCode];
    }];
    return [code componentsJoinedByString: @", "];
}

@end
