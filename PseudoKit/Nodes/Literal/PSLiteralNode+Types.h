//
//  PSLiteralNode+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSLiteralNode.h"
#import "PSLiteralTypes.h"

@interface PSLiteralNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSLiteralTypes) type;

#pragma mark - Helpers

+ (nullable NSNumber *) typeForTokenType: (PSTokenTypes) tokenType;

@end
