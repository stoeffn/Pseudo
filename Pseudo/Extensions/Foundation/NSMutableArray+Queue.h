//
//  NSMutableArray+Queue.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Queue)

- (id) dequeue;

- (void) enqueue: (id) obj;

@end
