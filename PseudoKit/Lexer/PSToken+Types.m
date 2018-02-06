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
        _tokens = @{@",":           @(PSTokenTypesComma),
                    @":":           @(PSTokenTypesColon),
                    @";":           @(PSTokenTypesSemicolon),

                    @".":           @(PSTokenTypesPoint),
                    @"(":           @(PSTokenTypesOpeningParenthesis),
                    @")":           @(PSTokenTypesClosingParenthesis),
                    @"[":           @(PSTokenTypesOpeningBracket),
                    @"]":           @(PSTokenTypesClosingBracket),

                    @"+":           @(PSTokenTypesPlus),
                    @"-":           @(PSTokenTypesMinus),
                    @"*":           @(PSTokenTypesTimes),
                    @"/":           @(PSTokenTypesDividedBy),
                    @"div":         @(PSTokenTypesDividedAsIntegerBy),
                    @"mod":         @(PSTokenTypesModulo),

                    @"=":           @(PSTokenTypesEquals),
                    @"≠":           @(PSTokenTypesNotEquals),
                    @"!=":          @(PSTokenTypesNotEquals),
                    @">":           @(PSTokenTypesGreaterThan),
                    @"≧":           @(PSTokenTypesGreaterThanOrEquals),
                    @">=":          @(PSTokenTypesGreaterThanOrEquals),
                    @"<":           @(PSTokenTypesLessThan),
                    @"≦":           @(PSTokenTypesLessThanOrEquals),
                    @"<=":          @(PSTokenTypesLessThanOrEquals),

                    @"←":           @(PSTokenTypesAssign),
                    @"<-":          @(PSTokenTypesAssign),

                    @"not":         @(PSTokenTypesNot),

                    @"if":          @(PSTokenTypesIf),
                    @"then":        @(PSTokenTypesThen),
                    @"else":        @(PSTokenTypesElse),

                    @"for":         @(PSTokenTypesFor),
                    @"in":          @(PSTokenTypesIn),
                    @"to":          @(PSTokenTypesTo),
                    @"downto":      @(PSTokenTypesDownTo),
                    @"do":          @(PSTokenTypesDo),
                    @"while":       @(PSTokenTypesWhile),
                    @"until":       @(PSTokenTypesUntil),
                    @"break":       @(PSTokenTypesBreak),
                    @"continue":    @(PSTokenTypesContinue),

                    @"algorithm":   @(PSTokenTypesAlgorithm),
                    @"return":      @(PSTokenTypesReturn),

                    @"new":         @(PSTokenTypesNew),

                    @"null":        @(PSTokenTypesNull),
                    @"true":        @(PSTokenTypesTrue),
                    @"false":       @(PSTokenTypesFalse)};
    });
    return _tokens;
}

+ (nonnull NSCharacterSet *) ambiguousDelimiterCharacterSet {
    static NSMutableCharacterSet *_characters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _characters = [[NSMutableCharacterSet alloc] init];
        [_characters addCharactersInString: @"!<>"];
    });
    return _characters;
}

+ (nonnull NSCharacterSet *) delimiterCharacterSet {
    static NSMutableCharacterSet *_delimiters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _delimiters = NSMutableCharacterSet.whitespaceAndNewlineCharacterSet;
        [_delimiters addCharactersInString: @",:;.()[]+-*/!=≠>≧<≦←"];
    });
    return _delimiters;
}

+ (nonnull NSString *) stringDelimiterCharacter {
    return @"\"";
}

+ (nonnull NSString *) stringEscapeCharacter {
    return @"\\";
}

+ (nonnull NSDictionary<NSString *, NSString *> *) escapableCharacters {
    static NSDictionary *_characters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _characters = @{@"\\":  @"\\",
                        @"\"":  @"\"",
                        @"n":   @"\n",
                        @"t":   @"\t"};
    });
    return _characters;
}

+ (nonnull NSString *) floatingPointCharacter {
    return @".";
}

+ (nonnull NSString *) commentStartCharacter {
    return @"/";
}

+ (nonnull NSNumberFormatter *) numberFormatter {
    static NSNumberFormatter *_formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatter = [[NSNumberFormatter alloc] init];
        _formatter.decimalSeparator = PSToken.floatingPointCharacter;
        _formatter.lenient = NO;
    });
    return _formatter;
}

#pragma mark - Description

+ (nonnull NSString *) descriptionForTokenType: (PSTokenTypes) tokenType {
    switch (tokenType) {
        case PSTokenTypesComma:                 return @"COMMA";
        case PSTokenTypesColon:                 return @"COLON";
        case PSTokenTypesSemicolon:             return @"SEMICOLON";
        case PSTokenTypesPoint:                 return @"POINT";
        case PSTokenTypesOpeningParenthesis:    return @"OPENING_PARENTHESIS";
        case PSTokenTypesClosingParenthesis:    return @"CLOSING_PARENTHESIS";
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
