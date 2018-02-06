//
//  PSAlgorithmNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSAlgorithmNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSAlgorithmNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    if (self.typeIdentifier) {
        return [[NSString alloc] initWithFormat: @"%@.prototype.%@ = function(%@) { %@ };",
                self.typeIdentifier, self.identifier, self.parametersJavaScriptCode, self.bodyNode.javaScriptCode];
    }

    return [[NSString alloc] initWithFormat: @"var %@ = function(%@) { %@ };",
            self.identifier, self.parametersJavaScriptCode, self.bodyNode.javaScriptCode];
}

- (nonnull NSString *) parametersJavaScriptCode {
    NSMutableArray<NSString *> *code = [NSMutableArray arrayWithCapacity: self.parameterNodes.count];
    [self.parameterNodes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        [code addObject: ((PSNode *) obj).javaScriptCode];
    }];
    return [code componentsJoinedByString: @", "];
}

@end
