//
//  PSInterpreting.h
//  PseudoKit
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSInterpreting <NSObject>

#pragma mark - Executing Code

- (nullable NSString *) executePseudoCode: (nonnull NSString *) code
                                    error: (NSError * __nullable __autoreleasing * __null_unspecified) error;

@end
