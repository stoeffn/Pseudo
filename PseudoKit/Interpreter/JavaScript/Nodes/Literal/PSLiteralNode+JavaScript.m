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
    switch (self.type) {
        case PSLiteralTypesNull:    return @"null";
        case PSLiteralTypesTrue:    return @"true";
        case PSLiteralTypesFalse:   return @"false";
        case PSLiteralTypesNumber:  return [[NSString alloc] initWithFormat: @"%@", self.number];
        case PSLiteralTypesString:  return [[NSString alloc] initWithFormat: @"\"%@\"", self.string];
    }
}

@end
