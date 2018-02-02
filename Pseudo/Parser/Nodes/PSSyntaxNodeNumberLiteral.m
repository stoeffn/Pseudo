//
//  PSSyntaxNodeNumberLiteral.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNodeNumberLiteral.h"

@implementation PSSyntaxNodeNumberLiteral

- (instancetype) initWithValue: (NSNumber *) value {
    if (self = [super init]) {
        _value = value;
    }
    return self;
}

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ value: %@>",
            NSStringFromClass([self class]), self.value];
}

@end
