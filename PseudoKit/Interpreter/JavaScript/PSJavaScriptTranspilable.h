//
//  PSJavaScriptTranspilable.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

@protocol PSJavaScriptTranspilable <NSObject>

#pragma mark - Transpiling

- (nonnull NSString *) javaScriptCode;

@end
