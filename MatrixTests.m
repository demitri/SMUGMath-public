//
//  MatrixTests.m
//  SMUGMath
//
//  Created by Christopher Liscio on 12/16/09.
//  Copyright 2009 SuperMegaUltraGroovy. All rights reserved.
//

#import "MatrixTests.h"
#import <SMUGMath/SMUGMath.h>
#import <Accelerate/Accelerate.h>

@implementation MatrixTests

- (void)testSolver
{
    SMUGRealMatrix *m = [[SMUGRealMatrix alloc] initWithRows:3 columns:3];
    
    [m setComponent: 1.1 atRow:0 column:0];
    [m setComponent: 2.2 atRow:0 column:1];
    [m setComponent:-3.3 atRow:0 column:2];

    [m setComponent: 4.4 atRow:1 column:0];
    [m setComponent:-5.5 atRow:1 column:1];
    [m setComponent: 6.6 atRow:1 column:2];
    
    [m setComponent:-7.7 atRow:2 column:0];
    [m setComponent: 8.8 atRow:2 column:1];
    [m setComponent: 9.9 atRow:2 column:2];
    
    SMUGRealVector *b = [SMUGRealVector realVectorWithLength:3];
    [b setComponent:0.0 atIndex:0];
    [b setComponent:5.5 atIndex:1];
    [b setComponent:11 atIndex:2];
    
    SMUGRealVector *x = [m solutionWith_b:b];
    
    STAssertEqualsWithAccuracy( [x componentAtIndex:0], 1.0f, 0.000001, @"Solution incorrect" );
    STAssertEqualsWithAccuracy( [x componentAtIndex:0], 1.0f, 0.000001, @"Solution incorrect" );
    STAssertEqualsWithAccuracy( [x componentAtIndex:0], 1.0f, 0.000001, @"Solution incorrect" );
}

@end
