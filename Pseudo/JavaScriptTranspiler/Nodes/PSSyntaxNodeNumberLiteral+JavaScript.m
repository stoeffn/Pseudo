//
//  PSSyntaxNodeNumberLiteral+JavaScript.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSSyntaxNodeNumberLiteral+JavaScript.h"

@implementation PSSyntaxNodeNumberLiteral (JavaScript)

- (NSString *) javaScriptCode {
    return self.value.stringValue;
}

@end
