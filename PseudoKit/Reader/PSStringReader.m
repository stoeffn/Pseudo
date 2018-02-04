//
//  PSStringReader.m
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSStringReader.h"

@interface PSStringReader ()

#pragma mark - State

@property (nonatomic, copy, nullable) NSString *currentCharacter;

@property (nonatomic, copy, nullable) NSString *nextCharacter;

@property (nonatomic) NSUInteger currentPosition;

@end

@implementation PSStringReader

#pragma mark - Life Cycle

- (nonnull instancetype) initWithString: (nonnull NSString *) string {
    if (self = [super init]) {
        _string = string;
        _currentPosition = 0;

        [self advanceToFirstCharacter];
    }
    return self;
}

#pragma mark - Description

- (NSString *) description {
    return [NSString stringWithFormat: @"<%@ String: '%@'>", NSStringFromClass([self class]), self.string];
}

#pragma mark - Advancing

- (nullable NSString *) advance {
    if (self.currentPosition >= self.string.length) {
        self.currentCharacter = self.nextCharacter;
        self.nextCharacter = NULL;
        return NULL;
    }

    void (^enumerateNextCharacter)(NSString *, NSRange, NSRange, BOOL *) = ^(NSString *inSubstring,
                                                                             NSRange inSubstringRange,
                                                                             NSRange inEnclosingRange,
                                                                             BOOL *outStop) {
        self.currentCharacter = self.nextCharacter;
        self.nextCharacter = inSubstring;
        self.currentPosition += inSubstring.length;
        *outStop = YES;
    };

    NSRange enumerationRange = NSMakeRange(self.currentPosition, self.string.length - self.currentPosition);
    [self.string enumerateSubstringsInRange: enumerationRange
                                    options: NSStringEnumerationByComposedCharacterSequences
                                 usingBlock: enumerateNextCharacter];

    return self.nextCharacter;
}

- (void) advanceToFirstCharacter {
    [self advance];
    [self advance];
}

@end
