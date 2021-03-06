//
//  PSLiteralNode.m
//  PseudoKit
//
//  Created by Steffen Ryll on 03.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSLiteralNode.h"
#import "PSLiteralNode+Types.h"

@implementation PSLiteralNode

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                                  type: (PSLiteralTypes) type
                                string: (nullable NSString *) string
                                number: (nullable NSNumber *) number {
    if (self = [super initWithToken: token]) {
        _type = type;
        _string = string;
        _number = number;
    }
    return self;
}

- (nonnull instancetype) initWithType: (PSLiteralTypes) type
                               string: (nullable NSString *) string
                               number: (nullable NSNumber *) number {
    return [self initWithToken: NULL type: type string: string number: number];
}

- (nonnull instancetype) initWithType: (PSLiteralTypes) type {
    return [self initWithToken: NULL type: type string: NULL number: NULL];
}

- (nonnull instancetype) initWithString: (nullable NSString *) string {
    return [self initWithToken: NULL type: PSLiteralTypesString string: string number: NULL];
}

- (nonnull instancetype) initWithNumber: (nullable NSNumber *) number {
    return [self initWithToken: NULL type: PSLiteralTypesNumber string: NULL number: number];
}

#pragma mark - Description

- (nonnull NSString *) description {
    return [[NSString alloc] initWithFormat: @"<%@ token: %@, type: %@, string: %@, number: %@>",
            NSStringFromClass([self class]), self.token, [PSLiteralNode descriptionForType: self.type], self.string,
            self.number];
}

#pragma mark - Equality

- (BOOL) isEqual: (id) object {
    return [super isEqual: object]
        && [object isKindOfClass: [self class]]
        && [self isEqualToNumberLiteralNode: (PSLiteralNode *) object];
}

- (BOOL) isEqualToNumberLiteralNode: (PSLiteralNode *) node {
    return node != NULL
        && self.type == node.type
        && ((!self.string && !node.string) || [self.string isEqual: node.string])
        && ((!self.number && !node.number) || [self.number isEqual: node.number]);
}

@end
