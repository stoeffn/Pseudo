//
//  PSCallNode+Types.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSCallNode+Types.h"

@implementation PSCallNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSCallTypes) type {
    switch (type) {
        case PSCallTypesVariable:       return @"VARIABLE";
        case PSCallTypesFunction:       return @"FUNCTION";
        case PSCallTypesSubscript:      return @"SUBSCRIPT";
        case PSCallTypesConstructor:    return @"CONSTRUCTOR";
    }
}

@end
