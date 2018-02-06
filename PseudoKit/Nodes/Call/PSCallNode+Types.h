//
//  PSCallNode+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSCallNode.h"
#import "PSCallTypes.h"
#import "PSTokenTypes.h"

@interface PSCallNode (Types)

#pragma mark - Description

+ (nonnull NSString *) descriptionForType: (PSCallTypes) type;

@end
