//
//  PSJavaScriptTranspiler.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"

@interface PSJavaScriptTranspiler : NSObject

@property (nonatomic, nonnull) PSNode *node;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithNode: (nonnull PSNode *) node;

#pragma mark - Transpiling

- (nonnull NSString *) code;

@end
