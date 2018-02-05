//
//  PSBinaryOperationNode+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSBinaryOperationNode.h"
#import "PSBinaryOperationTypes.h"
#import "PSTokenTypes.h"

@interface PSBinaryOperationNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSBinaryOperationTypes) type;

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType;

@end
