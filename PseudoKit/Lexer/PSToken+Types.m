//
//  PSToken+Types.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSToken+Types.h"
#import "PSTokenTypes.h"

@implementation PSToken (Types)

#pragma mark - Constants

+ (nonnull NSDictionary<NSString *, PSToken *> *) sharedTokens {
    static NSDictionary *_tokens;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tokens = @{@",": [[PSToken alloc] initWithType: PSTokenTypesComma],
                    @":": [[PSToken alloc] initWithType: PSTokenTypesColon],
                    @";": [[PSToken alloc] initWithType: PSTokenTypesSemicolon],

                    @".": [[PSToken alloc] initWithType: PSTokenTypesPoint],
                    @"(": [[PSToken alloc] initWithType: PSTokenTypesOpeningParenthesis],
                    @")": [[PSToken alloc] initWithType: PSTokenTypesClosingParanthesis],
                    @"[": [[PSToken alloc] initWithType: PSTokenTypesOpeningBracket],
                    @"]": [[PSToken alloc] initWithType: PSTokenTypesClosingBracket],

                    @"+": [[PSToken alloc] initWithType: PSTokenTypesPlus],
                    @"-": [[PSToken alloc] initWithType: PSTokenTypesMinus],
                    @"*": [[PSToken alloc] initWithType: PSTokenTypesTimes],
                    @"/": [[PSToken alloc] initWithType: PSTokenTypesDividedBy],
                    @"div": [[PSToken alloc] initWithType: PSTokenTypesDividedAsIntegerBy],
                    @"mod": [[PSToken alloc] initWithType: PSTokenTypesModulo],

                    @"=": [[PSToken alloc] initWithType: PSTokenTypesEquals],
                    @"≠": [[PSToken alloc] initWithType: PSTokenTypesNotEquals],
                    @">": [[PSToken alloc] initWithType: PSTokenTypesGreaterThan],
                    @"≧": [[PSToken alloc] initWithType: PSTokenTypesGreaterThanOrEquals],
                    @"<": [[PSToken alloc] initWithType: PSTokenTypesLessThan],
                    @"≦": [[PSToken alloc] initWithType: PSTokenTypesLessThanOrEquals],

                    @"←": [[PSToken alloc] initWithType: PSTokenTypesAssign],

                    @"not": [[PSToken alloc] initWithType: PSTokenTypesNot],

                    @"for": [[PSToken alloc] initWithType: PSTokenTypesFor],
                    @"in": [[PSToken alloc] initWithType: PSTokenTypesIn],
                    @"to": [[PSToken alloc] initWithType: PSTokenTypesTo],
                    @"downto": [[PSToken alloc] initWithType: PSTokenTypesDownTo],
                    @"do": [[PSToken alloc] initWithType: PSTokenTypesDo],
                    @"while": [[PSToken alloc] initWithType: PSTokenTypesWhile],
                    @"until": [[PSToken alloc] initWithType: PSTokenTypesUntil],
                    @"break": [[PSToken alloc] initWithType: PSTokenTypesBreak],
                    @"continue": [[PSToken alloc] initWithType: PSTokenTypesContinue],

                    @"algorithm": [[PSToken alloc] initWithType: PSTokenTypesAlgorithm],
                    @"return": [[PSToken alloc] initWithType: PSTokenTypesReturn],

                    @"new": [[PSToken alloc] initWithType: PSTokenTypesNew],

                    @"null": [[PSToken alloc] initWithType: PSTokenTypesNull],
                    @"true": [[PSToken alloc] initWithType: PSTokenTypesTrue],
                    @"false": [[PSToken alloc] initWithType: PSTokenTypesFalse]
                    };
    });
    return _tokens;
}

+ (nonnull NSDictionary<NSString *, NSString *> *) aliases {
    static NSDictionary *_aliases;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _aliases = @{
                     @"!=": @"≠",
                     @">=": @"≧",
                     @"<=": @"≦",
                     @"<-": @"←"
                     };
    });
    return _aliases;
}

@end
