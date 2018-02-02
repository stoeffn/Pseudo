//
//  PSTokenType.h
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#ifndef PSTokenType_h
#define PSTokenType_h

typedef NS_ENUM(NSInteger, PSTokenType) {
    PSTokenTypeAlgorithm,
    PSTokenTypeReturn,

    PSTokenTypeIdentifier,
    PSTokenTypeNumberLiteral,

    PSTokenTypeOpeningParenthesis,
    PSTokenTypeClosingParenthesis,
    PSTokenTypeOpeningBrace,
    PSTokenTypeClosingBrace,
    PSTokenTypeColon,
    PSTokenTypePoint
};

#endif /* PSTokenType_h */
