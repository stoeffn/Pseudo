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

+ (nonnull NSCharacterSet *) delimiters {
    static NSMutableCharacterSet *_delimiters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _delimiters = NSMutableCharacterSet.whitespaceAndNewlineCharacterSet;
        [_delimiters addCharactersInString: @",:;.()[]+-*/=≠>≧<≦←"];
    });
    return _delimiters;
}

#pragma mark - Description

+ (nonnull NSString *) descriptionForTokenType: (PSTokenTypes) tokenType {
    switch (tokenType) {
        case PSTokenTypesComma:                 return @"COMMA";
        case PSTokenTypesColon:                 return @"COLON";
        case PSTokenTypesSemicolon:             return @"SEMICOLON";
        case PSTokenTypesEndOfFile:             return @"END_OF_FILE";
        case PSTokenTypesPoint:                 return @"POINT";
        case PSTokenTypesOpeningParenthesis:    return @"OPENING_PARENTHESIS";
        case PSTokenTypesClosingParanthesis:    return @"CLOSING_PARENTHESIS";
        case PSTokenTypesOpeningBracket:        return @"OPENING_BRACKET";
        case PSTokenTypesClosingBracket:        return @"CLOSING_BRACKET";
        case PSTokenTypesPlus:                  return @"PLUS";
        case PSTokenTypesMinus:                 return @"MINUS";
        case PSTokenTypesTimes:                 return @"TIMES";
        case PSTokenTypesDividedBy:             return @"DIVIDED_BY";
        case PSTokenTypesDividedAsIntegerBy:    return @"DIVIDED_AS_INTEGER_BY";
        case PSTokenTypesModulo:                return @"MODULO";
        case PSTokenTypesEquals:                return @"EQUALS";
        case PSTokenTypesNotEquals:             return @"NOT_EQUALS";
        case PSTokenTypesGreaterThan:           return @"GREATER_THAN";
        case PSTokenTypesGreaterThanOrEquals:   return @"GREATER_THAN_OR_EQUALS";
        case PSTokenTypesLessThan:              return @"LESS_THAN";
        case PSTokenTypesLessThanOrEquals:      return @"LESS_THAN_OR_EQUALS";
        case PSTokenTypesAssign:                return @"ASSIGN";
        case PSTokenTypesNot:                   return @"NOT";
        case PSTokenTypesIf:                    return @"IF";
        case PSTokenTypesThen:                  return @"THEN";
        case PSTokenTypesElse:                  return @"ELSE";
        case PSTokenTypesFor:                   return @"FOR";
        case PSTokenTypesIn:                    return @"IN";
        case PSTokenTypesTo:                    return @"TO";
        case PSTokenTypesDownTo:                return @"DOWNTO";
        case PSTokenTypesDo:                    return @"DO";
        case PSTokenTypesWhile:                 return @"WHILE";
        case PSTokenTypesRepeat:                return @"REPEAT";
        case PSTokenTypesUntil:                 return @"UNTIL";
        case PSTokenTypesBreak:                 return @"BREAK";
        case PSTokenTypesContinue:              return @"CONTINUE";
        case PSTokenTypesAlgorithm:             return @"ALGORITHM";
        case PSTokenTypesReturn:                return @"RETURN";
        case PSTokenTypesNew:                   return @"NEW";
        case PSTokenTypesNull:                  return @"NULL";
        case PSTokenTypesTrue:                  return @"TRUE";
        case PSTokenTypesFalse:                 return @"FALSE";
        case PSTokenTypesIdentifier:            return @"IDENTIFIER";
        case PSTokenTypesNumber:                return @"NUMBER";
        case PSTokenTypesString:                return @"STRING";
    }
}

@end
