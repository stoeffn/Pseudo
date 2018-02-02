//
//  PSSyntaxNodeKeyword.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNodeReturn.h"

@implementation PSSyntaxNodeReturn

- (NSString *) description {
    return [[NSString alloc] initWithFormat: @"<PSSyntaxNodeReturn children: %@>", self.children];
}

@end
