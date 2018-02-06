//
//  Application.h
//  Pseudo
//
//  Created by Steffen Ryll on 06.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Application : NSObject

#pragma mark - Life Cycle

- (BOOL) executeWithArguments: (nonnull NSArray<NSString *> *) arguments;

@end
