//
//  PSLexer.h
//  Pseudo
//
//  Created by Steffen Ryll on 01.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSToken.h"

@interface PSLexer : NSObject

@property (nonatomic, readonly) NSString *code;

- (instancetype) initWithCode: (NSString *) code;

- (NSArray<PSToken *> *) tokens;

@end
