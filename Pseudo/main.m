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
        Application *application = [[Application alloc] init];
        return [application executeWithArguments: NSProcessInfo.processInfo.arguments];
    }
}
