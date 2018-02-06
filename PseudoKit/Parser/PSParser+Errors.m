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

+ (nonnull NSError *) expectedOneOfTokenTypes: (nonnull NSSet<NSNumber *> *) expectedTokenTypes
                       butFoundTokenTypeError: (PSTokenTypes) actualTokenType {
    NSMutableArray<NSString *> *expectedTokenTypeDescriptions = [[NSMutableArray alloc] init];
    [expectedTokenTypes enumerateObjectsUsingBlock: ^(NSNumber * _Nonnull tokenType, BOOL * _Nonnull stop) {
        [expectedTokenTypeDescriptions addObject: [PSToken descriptionForTokenType: tokenType.integerValue]];
    }];

    NSString *errorMessage = [[NSString alloc] initWithFormat: @"Expected %@ but found %@.",
                              [expectedTokenTypeDescriptions componentsJoinedByString: @", "],
                              [PSToken descriptionForTokenType: actualTokenType]];

    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorMessage};
    return [NSError errorWithDomain: PSParserErrorDomain code: PSParserErrorTypesFailedExpectation userInfo: userInfo];
}

+ (nonnull NSError *) endOfFileError {
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Unexpectedly found end-of-file while parsing."};
    return [NSError errorWithDomain: PSParserErrorDomain code: PSParserErrorTypesEndOfFile userInfo: userInfo];
}

@end
