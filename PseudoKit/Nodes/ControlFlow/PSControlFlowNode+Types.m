//
//  PSControlFlowNode+Types.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSControlFlowNode+Types.h"

@implementation PSControlFlowNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSControlFlowTypes) type {
    switch (type) {
        case PSControlFlowTypesBreak:       return @"BREAK";
        case PSControlFlowTypesContinue:    return @"CONTINUE";
        case PSControlFlowTypesReturn:      return @"RETURN";
    }
}

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType {
    switch (tokenType) {
        case PSTokenTypesBreak:     return @(PSControlFlowTypesBreak);
        case PSTokenTypesContinue:  return @(PSControlFlowTypesContinue);
        case PSTokenTypesReturn:    return @(PSControlFlowTypesReturn);
        default:                    return NULL;
    }
}

@end
