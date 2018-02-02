//
//  NSMutableArray+Queue.m
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

- (id) dequeue {
    if ([self count] == 0){
        return NULL;
    }

    id firstObject = [self objectAtIndex: 0];
    if (firstObject != nil) {
        [self removeObjectAtIndex: 0];
    }
    return firstObject;
}

- (void) enqueue: (id) anObject {
    [self addObject: anObject];
}

@end
