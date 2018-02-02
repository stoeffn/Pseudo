//
//  PSSyntaxNodeAlgorithm.h
//  Pseudo
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSToken.h"
#import "PSSyntaxNode.h"

@interface PSSyntaxNodeAlgorithm : PSSyntaxNode

@property (nonatomic) NSString *identifier;

@property (nonatomic) NSString *returnType;

- (instancetype) initWithIdentifier: (NSString *) identifier
                      andReturnType: (NSString *) returnType
                        andChildren: (NSArray<PSSyntaxNode *> *) children;

+ (PSSyntaxNode *) nextSyntaxNodeFor: (NSMutableArray<PSToken *> *) token;

+ (PSSyntaxNodeAlgorithm *) nextAlgorithmSyntaxNodeFor: (NSMutableArray *) tokens;

@end
