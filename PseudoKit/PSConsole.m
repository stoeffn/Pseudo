//
//  PSConsole.m
//  PseudoKit
//
//  Created by Steffen Ryll on 06.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSConsole.h"

@implementation PSConsole

#pragma mark - Reading and Writing

+ (nullable NSString *) awaitString {
    NSData *data = [NSFileHandle.fileHandleWithStandardInput availableData];
    if (!data.length) return NULL;

    return [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
}

+ (nullable NSString *) awaitSanitizedString {
    NSString *string = [self awaitString];
    if (!string) return NULL;

    return [[string componentsSeparatedByCharactersInSet: PSConsole.illegalAndControlCharacterSet] componentsJoinedByString: @""];
}

+ (void) writeString: (nonnull NSString *) string {
    NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
    [NSFileHandle.fileHandleWithStandardOutput writeData: data];
}

+ (void) writeErrorString: (nonnull NSString *) string {
    NSData *data = [string dataUsingEncoding: NSUTF8StringEncoding];
    [NSFileHandle.fileHandleWithStandardError writeData: data];
}

#pragma mark - Constants

+ (nonnull NSCharacterSet *) illegalAndControlCharacterSet {
    static NSMutableCharacterSet *_delimiters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _delimiters = [[NSMutableCharacterSet alloc] init];
        [_delimiters formUnionWithCharacterSet: NSMutableCharacterSet.controlCharacterSet];
        [_delimiters formUnionWithCharacterSet: NSMutableCharacterSet.illegalCharacterSet];
        [_delimiters addCharactersInString: @""]; // Characters produced by arrow keys.
    });
    return _delimiters;
}

@end
