//
//  PSParser+Errors.h
//  PseudoKit
//
//  Created by Steffen Ryll on 06.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <PseudoKit/PseudoKit.h>

FOUNDATION_EXPORT NSString * _Nonnull const PSParserErrorDomain;

@interface PSParser (Errors)

+ (nonnull NSError *) expectedOneOfTokenTypes: (nonnull NSSet<NSNumber *> *) expectedTokenTypes
                       butFoundTokenTypeError: (PSTokenTypes) actualTokenType;

+ (nonnull NSError *) endOfFileError;

@end
