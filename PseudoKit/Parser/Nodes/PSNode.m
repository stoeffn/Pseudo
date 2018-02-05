//
//  PSNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSNode.h"

@implementation PSNode

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token {
    if (self = [super init]) {
        _token = token;
    }
    return self;
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@>", NSStringFromClass([self class]), self.token];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return self == object || [object isKindOfClass: [self class]];
}

@end
