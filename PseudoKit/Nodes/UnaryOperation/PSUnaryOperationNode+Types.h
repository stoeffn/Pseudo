//
//  PSUnaryOperationNode+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSUnaryOperationNode.h"
#import "PSUnaryOperationTypes.h"
#import "PSTokenTypes.h"

@interface PSUnaryOperationNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSUnaryOperationTypes) type;

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType;

@end
