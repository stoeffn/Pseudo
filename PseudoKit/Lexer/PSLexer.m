//
//  PSLexer.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "PSLexer.h"
#import "PSToken.h"

@interface PSLexer ()

@property (nonatomic) NSUInteger currentCharacterIndex;

@end

@implementation PSLexer

- (instancetype) initWithCode: (NSString *) code {
    if (self = [super init]) {
        _code = code;
        _currentCharacterIndex = 0;
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ Code: '%@'>",
            NSStringFromClass([self class]), self.code];
}

- (PSToken *) nextToken {
    __block NSString *rawToken;
    void (^enumerateUntilNextToken)(NSString *, NSRange, NSRange, BOOL *) = ^(NSString *inSubstring,
                                                                 NSRange inSubstringRange,
                                                                 NSRange inEnclosingRange,
                                                                 BOOL *outStop) {
        NSRange delimiterMatch = [inSubstring rangeOfCharacterFromSet: PSLexer.delimitingCharacters];
        if (delimiterMatch.location == NSNotFound) {
            return;
        }

        NSRange rawTokenRange = NSMakeRange(self.currentCharacterIndex, inSubstringRange.location + inSubstringRange.length);
        rawToken = [self.code substringWithRange: rawTokenRange];
        *outStop = YES;
    };

    [self.code enumerateSubstringsInRange: NSMakeRange(self.currentCharacterIndex, self.code.length)
                                  options: NSStringEnumerationByComposedCharacterSequences
                               usingBlock: enumerateUntilNextToken];

    if (rawToken == NULL) {
        return NULL;
    }

    return [[PSToken alloc] initWithRawToken: rawToken];
}

- (void) reset {
    self.currentCharacterIndex = 0;
}

+ (NSCharacterSet *) delimitingCharacters {
    static NSMutableCharacterSet *_delimitingCharacters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _delimitingCharacters = NSMutableCharacterSet.whitespaceAndNewlineCharacterSet;
        [_delimitingCharacters addCharactersInString: @"(){}:."];
    });
    return _delimitingCharacters;
}

@end
