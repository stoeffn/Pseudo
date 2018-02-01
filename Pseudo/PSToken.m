//
//  PSToken.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSToken.h"

@implementation PSToken

- (instancetype) initWithType: (PSTokenType) type {
    if (self = [super init]) {
        _type = type;
    }

    return self;
}

@end
