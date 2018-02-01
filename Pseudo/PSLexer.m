//
//  PSLexer.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSLexer.h"

@implementation PSLexer

- (instancetype) initWithCode: (NSString *) code {
    if (self = [super init]) {
        _code = code;
    }

    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"<PSLexer Code: \"%@\">", [self code]];
}

- (NSArray<PSToken *> *) tokens {
    NSMutableArray *tokens = [[NSMutableArray alloc] init];
    return tokens;
}

@end
