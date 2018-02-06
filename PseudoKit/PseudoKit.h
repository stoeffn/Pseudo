//
//  PseudoKit.h
//  PseudoKit
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for PseudoKit.
FOUNDATION_EXPORT double PseudoKitVersionNumber;

//! Project version string for PseudoKit.
FOUNDATION_EXPORT const unsigned char PseudoKitVersionString[];

#import <PseudoKit/Constants.h>
#import <PseudoKit/Macros.h>

#import <PseudoKit/PSReading.h>
#import <PseudoKit/PSStringReader.h>

#import <PseudoKit/PSLexing.h>
#import <PseudoKit/PSLexer.h>
#import <PseudoKit/PSToken.h>
#import <PseudoKit/PSToken+Types.h>
#import <PseudoKit/PSTokenTypes.h>

#import <PseudoKit/PSNode.h>
#import <PseudoKit/PSAlgorithmNode.h>
#import <PseudoKit/PSBinaryOperationTypes.h>
#import <PseudoKit/PSBinaryOperationNode.h>
#import <PseudoKit/PSBinaryOperationNode+Types.h>
#import <PseudoKit/PSCallTypes.h>
#import <PseudoKit/PSCallNode.h>
#import <PseudoKit/PSCallNode+Types.h>
#import <PseudoKit/PSCompoundNode.h>
#import <PseudoKit/PSConditionNode.h>
#import <PseudoKit/PSControlFlowTypes.h>
#import <PseudoKit/PSControlFlowNode.h>
#import <PseudoKit/PSControlFlowNode+Types.h>
#import <PseudoKit/PSLiteralTypes.h>
#import <PseudoKit/PSLiteralNode.h>
#import <PseudoKit/PSLiteralNode+Types.h>
#import <PseudoKit/PSParameterNode.h>
#import <PseudoKit/PSUnaryOperationTypes.h>
#import <PseudoKit/PSUnaryOperationNode.h>
#import <PseudoKit/PSUnaryOperationNode+Types.h>

#import <PseudoKit/PSParser.h>

#import <PseudoKit/PSInterpreting.h>
#import <PseudoKit/PSJavaScriptTranspilable.h>
#import <PseudoKit/PSJavaScriptInterpreter.h>
#import <PseudoKit/PSNode+JavaScript.h>
#import <PseudoKit/PSAlgorithmNode+JavaScript.h>
#import <PseudoKit/PSBinaryOperationNode+JavaScript.h>
#import <PseudoKit/PSCallNode+JavaScript.h>
#import <PseudoKit/PSCompoundNode+JavaScript.h>
#import <PseudoKit/PSConditionNode+JavaScript.h>
#import <PseudoKit/PSControlFlowNode+JavaScript.h>
#import <PseudoKit/PSLiteralNode+JavaScript.h>
#import <PseudoKit/PSParameterNode+JavaScript.h>
#import <PseudoKit/PSUnaryOperationNode+JavaScript.h>

#import <PseudoKit/PSConsole.h>
#import <PseudoKit/PSREPL.h>
