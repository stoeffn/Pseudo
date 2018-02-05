//
//  PSJavaScriptTranspiler.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSJavaScriptTranspiler.h"
#import "PSNode+JavaScript.h"

@implementation PSJavaScriptTranspiler

#pragma mark - Life Cycle

- (nonnull instancetype) initWithNode: (nonnull PSNode *) node {
    if (self = [super init]) {
        _node = node;
    }
    return self;
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [NSString stringWithFormat: @"<%@ node: %@, code: %@>", NSStringFromClass([self class]), self.node, self.code];
}

#pragma mark - Transpiling

- (nonnull NSString *) code {
    return self.node.javaScriptCode;
}

@end
