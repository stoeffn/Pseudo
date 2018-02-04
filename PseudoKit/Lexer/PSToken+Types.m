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

+ (nonnull NSDictionary<NSString *, NSNumber *> *) tokenTypes {
    static NSDictionary *_tokens;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tokens = @{@",":           [[NSNumber alloc] initWithInt: PSTokenTypesComma],
                    @":":           [[NSNumber alloc] initWithInt: PSTokenTypesColon],
                    @";":           [[NSNumber alloc] initWithInt: PSTokenTypesSemicolon],

                    @".":           [[NSNumber alloc] initWithInt: PSTokenTypesPoint],
                    @"(":           [[NSNumber alloc] initWithInt: PSTokenTypesOpeningParenthesis],
                    @")":           [[NSNumber alloc] initWithInt: PSTokenTypesClosingParanthesis],
                    @"[":           [[NSNumber alloc] initWithInt: PSTokenTypesOpeningBracket],
                    @"]":           [[NSNumber alloc] initWithInt: PSTokenTypesClosingBracket],

                    @"+":           [[NSNumber alloc] initWithInt: PSTokenTypesPlus],
                    @"-":           [[NSNumber alloc] initWithInt: PSTokenTypesMinus],
                    @"*":           [[NSNumber alloc] initWithInt: PSTokenTypesTimes],
                    @"/":           [[NSNumber alloc] initWithInt: PSTokenTypesDividedBy],
                    @"div":         [[NSNumber alloc] initWithInt: PSTokenTypesDividedAsIntegerBy],
                    @"mod":         [[NSNumber alloc] initWithInt: PSTokenTypesModulo],

                    @"=":           [[NSNumber alloc] initWithInt: PSTokenTypesEquals],
                    @"≠":           [[NSNumber alloc] initWithInt: PSTokenTypesNotEquals],
                    @">":           [[NSNumber alloc] initWithInt: PSTokenTypesGreaterThan],
                    @"≧":           [[NSNumber alloc] initWithInt: PSTokenTypesGreaterThanOrEquals],
                    @"<":           [[NSNumber alloc] initWithInt: PSTokenTypesLessThan],
                    @"≦":           [[NSNumber alloc] initWithInt: PSTokenTypesLessThanOrEquals],

                    @"←":           [[NSNumber alloc] initWithInt: PSTokenTypesAssign],

                    @"not":         [[NSNumber alloc] initWithInt: PSTokenTypesNot],

                    @"for":         [[NSNumber alloc] initWithInt: PSTokenTypesFor],
                    @"in":          [[NSNumber alloc] initWithInt: PSTokenTypesIn],
                    @"to":          [[NSNumber alloc] initWithInt: PSTokenTypesTo],
                    @"downto":      [[NSNumber alloc] initWithInt: PSTokenTypesDownTo],
                    @"do":          [[NSNumber alloc] initWithInt: PSTokenTypesDo],
                    @"while":       [[NSNumber alloc] initWithInt: PSTokenTypesWhile],
                    @"until":       [[NSNumber alloc] initWithInt: PSTokenTypesUntil],
                    @"break":       [[NSNumber alloc] initWithInt: PSTokenTypesBreak],
                    @"continue":    [[NSNumber alloc] initWithInt: PSTokenTypesContinue],

                    @"algorithm":   [[NSNumber alloc] initWithInt: PSTokenTypesAlgorithm],
                    @"return":      [[NSNumber alloc] initWithInt: PSTokenTypesReturn],

                    @"new":         [[NSNumber alloc] initWithInt: PSTokenTypesNew],

                    @"null":        [[NSNumber alloc] initWithInt: PSTokenTypesNull],
                    @"true":        [[NSNumber alloc] initWithInt: PSTokenTypesTrue],
                    @"false":       [[NSNumber alloc] initWithInt: PSTokenTypesFalse]};
    });
    return _tokens;
}

+ (nonnull NSDictionary<NSString *, NSString *> *) aliases {
    static NSDictionary *_aliases;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _aliases = @{@"!=": @"≠",
                     @">=": @"≧",
                     @"<=": @"≦",
                     @"<-": @"←"};
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
