//
//  PSLiteralNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSLiteralNode+JavaScript.h"

@implementation PSLiteralNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    switch (self.type) {
        case PSLiteralTypesNull:    return @"null";
        case PSLiteralTypesTrue:    return @"true";
        case PSLiteralTypesFalse:   return @"false";
        case PSLiteralTypesNumber:  return self.number.stringValue;
        case PSLiteralTypesString:  return self.escapedJavaScriptString;
    }
}

- (nullable NSString *) escapedJavaScriptString {
    if (!self.string) return NULL;

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: @[self.string] options: 0 error: &error];

    if (error) return @"";

    NSString *string = [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding];
    return [string substringWithRange: NSMakeRange(1, string.length - 2)];
}

@end
