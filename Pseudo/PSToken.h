//
//  PSToken.h
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSTokenType.h"

@interface PSToken : NSObject

@property (nonatomic, readonly) PSTokenType type;

- (instancetype) initWithType: (PSTokenType) type;

@end
