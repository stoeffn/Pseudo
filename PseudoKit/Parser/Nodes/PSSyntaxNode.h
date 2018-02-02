//
//  PSSyntaxNode.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSSyntaxNode : NSObject

@property (nonatomic) NSMutableArray<PSSyntaxNode *> *children;

- (instancetype) initWithChildren: (NSMutableArray<PSSyntaxNode *> *) children;

@end
