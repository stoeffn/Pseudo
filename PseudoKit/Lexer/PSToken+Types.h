//
//  PSToken+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <PseudoKit/PseudoKit.h>

@interface PSToken (Types)

+ (nonnull NSDictionary<NSString *, PSToken *> *) sharedTokens;

@end
