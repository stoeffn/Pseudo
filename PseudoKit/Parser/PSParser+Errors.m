//
//  PSParser+Errors.m
//  PseudoKit
//
//  Created by Steffen Ryll on 06.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSParser+Errors.h"
#import "PSParserErrorTypes.h"

NSString * _Nonnull const PSParserErrorDomain = @"SteffenRyll.Pseudo.Parser";

@implementation PSParser (Errors)

+ (nonnull NSError *) failedExpectationError {
    return [NSError errorWithDomain: PSParserErrorDomain code: PSParserErrorTypesFailedExpectation userInfo: NULL];
}

+ (nonnull NSError *) endOfFileError {
    return [NSError errorWithDomain: PSParserErrorDomain code: PSParserErrorTypesEndOfFile userInfo: NULL];
}

@end
