//
//  PSControlFlowNode+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSControlFlowNode.h"
#import "PSControlFlowTypes.h"
#import "PSTokenTypes.h"

@interface PSControlFlowNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSControlFlowTypes) type;

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType;

@end
