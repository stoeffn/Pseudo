//
//  PSToken+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSToken.h"

@interface PSToken (Types)

#pragma mark - Constants

+ (nonnull NSDictionary<NSString *, NSNumber *> *) tokenTypes;

+ (nonnull NSCharacterSet *) ambiguousDelimiterCharacterSet;

+ (nonnull NSCharacterSet *) delimiterCharacterSet;

+ (nonnull NSString *) stringStartCharacter;

+ (nonnull NSString *) floatingPointCharacter;

+ (nonnull NSString *) commentStartCharacter;

+ (nonnull NSNumberFormatter *) numberFormatter;

#pragma mark - Description

+ (nonnull NSString *) descriptionForTokenType: (PSTokenTypes) tokenType;

@end
