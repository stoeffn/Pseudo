//
//  PSToken+Types.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <PseudoKit/PseudoKit.h>

@interface PSToken (Types)

#pragma mark - Constants

+ (nonnull NSDictionary<NSString *, NSNumber *> *) tokenTypes;

+ (nonnull NSCharacterSet *) ambiguousDelimiterCharacterSet;

+ (nonnull NSDictionary<NSString *, NSString *> *) aliases;

+ (nonnull NSCharacterSet *) delimiterCharacterSet;

+ (nonnull NSString *) stringStartCharacter;

+ (nonnull NSString *) floatingPointCharacter;

#pragma mark - Description

+ (nonnull NSString *) descriptionForTokenType: (PSTokenTypes) tokenType;

@end
