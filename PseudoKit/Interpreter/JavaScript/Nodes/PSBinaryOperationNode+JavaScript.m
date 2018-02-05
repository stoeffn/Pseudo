//
//  PSBinaryOperationNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSBinaryOperationNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSBinaryOperationNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    switch (self.type) {
        case PSBinaryOperationTypesAddition:
            return [[NSString alloc] initWithFormat: @"(%@ + %@)", self.left.javaScriptCode, self.right.javaScriptCode];
        case PSBinaryOperationTypesSubtraction:
            return [[NSString alloc] initWithFormat: @"(%@ - %@)", self.left.javaScriptCode, self.right.javaScriptCode];
        case PSBinaryOperationTypesMultiplication:
            return [[NSString alloc] initWithFormat: @"(%@ * %@)", self.left.javaScriptCode, self.right.javaScriptCode];
        case PSBinaryOperationTypesDivision:
            return [[NSString alloc] initWithFormat: @"(%@ / %@)", self.left.javaScriptCode, self.right.javaScriptCode];
        case PSBinaryOperationTypesIntegerDivision:
            return [[NSString alloc] initWithFormat: @"Math.floor(%@ / %@)", self.left.javaScriptCode, self.right.javaScriptCode];
        case PSBinaryOperationTypesModulo:
            return [[NSString alloc] initWithFormat: @"(%@ %% %@)", self.left.javaScriptCode, self.right.javaScriptCode];
    }
}

@end
