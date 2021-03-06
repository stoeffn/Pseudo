//
//  PSInterpreting.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"

@protocol PSInterpreting <NSObject>

#pragma mark - Executing Code

- (nullable NSString *) executeNode: (nonnull PSNode *) node;

- (nullable NSString *) executePseudoCode: (nonnull NSString *) code
                                    error: (NSError * __nullable __autoreleasing * __null_unspecified) error;

#pragma mark - Providing Native Algorithms

- (void) setObject: (nonnull id) object forKeyedSubscript: (nullable NSObject<NSCopying> *) key;

@end
