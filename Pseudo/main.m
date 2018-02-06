//
//  main.m
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Application.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        BOOL isSuccess = [[[Application alloc] init] executeWithArguments: NSProcessInfo.processInfo.arguments];
        return isSuccess ? EXIT_SUCCESS : EXIT_FAILURE;
    }
}
