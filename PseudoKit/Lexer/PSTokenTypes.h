//
//  PSTokenTypes.h
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

typedef NS_ENUM(NSInteger, PSTokenTypes) {
    PSTokenTypesComma,
    PSTokenTypesColon,
    PSTokenTypesSemicolon,
    PSTokenTypesEndOfFile,

    PSTokenTypesPoint,
    PSTokenTypesOpeningParenthesis,
    PSTokenTypesClosingParanthesis,
    PSTokenTypesOpeningBracket,
    PSTokenTypesClosingBracket,

    PSTokenTypesPlus,
    PSTokenTypesMinus,
    PSTokenTypesTimes,
    PSTokenTypesDividedBy,
    PSTokenTypesDividedAsIntegerBy,
    PSTokenTypesModulo,

    PSTokenTypesEquals,
    PSTokenTypesNotEquals,
    PSTokenTypesGreaterThan,
    PSTokenTypesGreaterThanOrEquals,
    PSTokenTypesLessThan,
    PSTokenTypesLessThanOrEquals,

    PSTokenTypesAssign,

    PSTokenTypesNot,

    PSTokenTypesIf,
    PSTokenTypesThen,
    PSTokenTypesElse,

    PSTokenTypesFor,
    PSTokenTypesIn,
    PSTokenTypesTo,
    PSTokenTypesDownTo,
    PSTokenTypesDo,
    PSTokenTypesWhile,
    PSTokenTypesRepeat,
    PSTokenTypesUntil,
    PSTokenTypesBreak,
    PSTokenTypesContinue,

    PSTokenTypesAlgorithm,
    PSTokenTypesReturn,

    PSTokenTypesNew,

    PSTokenTypesNull,
    PSTokenTypesTrue,
    PSTokenTypesFalse,
    PSTokenTypesIdentifier,
    PSTokenTypesNumber,
    PSTokenTypesString
};
