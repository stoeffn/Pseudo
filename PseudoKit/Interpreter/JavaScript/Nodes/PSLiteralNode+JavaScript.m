//
//  PSLiteralNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSLiteralNode+JavaScript.h"

@implementation PSLiteralNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    return [[NSString alloc] initWithFormat: @"%@", self.value];
}

@end
