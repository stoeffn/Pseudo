//
//  PSParameterNode+JavaScript.m
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "PSParameterNode+JavaScript.h"
#import "PSNode+JavaScript.h"

@implementation PSParameterNode (JavaScript)

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode {
    return self.identifier;
}

@end
