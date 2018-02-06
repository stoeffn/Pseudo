//
//  PSParameterNode.h
//  PseudoKit
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSNode.h"

@interface PSParameterNode : PSNode

@property (nonatomic, readonly, copy, nonnull) NSString *typeIdentifier;

@property (nonatomic, readonly, copy, nonnull) NSString *identifier;

#pragma mark - Life Cycle

- (nonnull instancetype) initWithToken: (nullable PSToken *) token __unavailable;

- (nonnull instancetype) initWithToken: (nullable PSToken *) token
                        typeIdentifier: (nonnull NSString *) typeIdentifier
                            identifier: (nonnull NSString *) identifier;

- (nonnull instancetype) initWithTypeIdentifier: (nonnull NSString *) typeIdentifier
                                     identifier: (nonnull NSString *) identifier;

@end
