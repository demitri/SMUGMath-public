//
//  ComplexVectorTests.m
//  SMUGFoundation
//
//  Created by Chris Liscio on 19/07/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "ComplexVectorTests.h"
#import <SMUGMath/SMUGMath.h>

@implementation ComplexVectorTests

- (void)testLength
{
    SMUGComplexVector   *a = [SMUGComplexVector complexVectorWithLength:4];
    
    STAssertEquals( [a length], (unsigned int)4, @"Unexpected number of components" );
}

- (void)testSettingComplexFloats
{
    SMUGComplexVector   *a = [SMUGComplexVector complexVectorWithLength:4];
    
    [a setComponent:1.0f atIndex:0];
    [a setComponent:1.0f atIndex:1];
    [a setComponent:1.0f atIndex:2];
    [a setComponent:1.0f atIndex:3];
    STAssertThrows( [a setComponent:1.0f atIndex:4], @"Throwing exception failed" );
    
    STAssertTrue( [a componentAtIndex:0] == (complex float)1.0f, @"Setting float failed" );
    STAssertTrue( [a componentAtIndex:1] == (complex float)1.0f, @"Setting float failed" );
    STAssertTrue( [a componentAtIndex:2] == (complex float)1.0f, @"Setting float failed" );    
    STAssertTrue( [a componentAtIndex:3] == (complex float)1.0f, @"Setting float failed" );
    STAssertThrows( [a componentAtIndex:4], @"Throwing exception failed" );
}

- (void)testScalarMultiplies
{
    SMUGComplexVector   *a = [SMUGComplexVector complexVectorWithLength:4];
    
    [a setComponent:(1.0f + I * 1.0f) atIndex:0];
    [a setComponent:(1.0f + I * 1.0f) atIndex:1];
    [a setComponent:(1.0f + I * 1.0f) atIndex:2];
    [a setComponent:(1.0f + I * 1.0f) atIndex:3];

    [a scaleBy:2.0f];
    
    STAssertTrue( [a componentAtIndex:0] == (2.0f + I * 2.0f), @"Scalar multiply failed" );
    STAssertTrue( [a componentAtIndex:1] == (2.0f + I * 2.0f), @"Scalar multiply failed" );
    STAssertTrue( [a componentAtIndex:2] == (2.0f + I * 2.0f), @"Scalar multiply failed" );
    STAssertTrue( [a componentAtIndex:3] == (2.0f + I * 2.0f), @"Scalar multiply failed" );
}

- (void)testComplexScalarMultiplies
{
    SMUGComplexVector   *a = [SMUGComplexVector complexVectorWithLength:4];
    
    [a setComponent:(1.0f + I * 1.0f) atIndex:0];
    [a setComponent:(1.0f + I * 1.0f) atIndex:1];
    [a setComponent:(1.0f + I * 1.0f) atIndex:2];
    [a setComponent:(1.0f + I * 1.0f) atIndex:3];
    
    [a complexScaleBy:I * 1.0f];
    
    STAssertTrue( [a componentAtIndex:0] == (-1.0f + I * 1.0f), @"Complex scalar multiply failed");
    STAssertTrue( [a componentAtIndex:1] == (-1.0f + I * 1.0f), @"Complex scalar multiply failed" );
    STAssertTrue( [a componentAtIndex:2] == (-1.0f + I * 1.0f), @"Complex scalar multiply failed" );
    STAssertTrue( [a componentAtIndex:3] == (-1.0f + I * 1.0f), @"Complex scalar multiply failed" );
}

- (void)testDataMultiplies
{
    SMUGComplexVector    *a = [SMUGComplexVector complexVectorWithLength:4];
    SMUGRealVector           *b = [SMUGRealVector realVectorWithLength:4];
    
    [a setComponent:1.0f atIndex:0];
    [a setComponent:1.0f atIndex:1];
    [a setComponent:1.0f atIndex:2];
    [a setComponent:1.0f atIndex:3];
    
    [b setComponent:2.0f atIndex:0];
    [b setComponent:2.0f atIndex:1];
    [b setComponent:2.0f atIndex:2];
    [b setComponent:2.0f atIndex:3];
    
    [a multiplyBy:b];
    
    STAssertTrue( [a componentAtIndex:0] == (complex float)2.0f, @"Data multiply failed" );
    STAssertTrue( [a componentAtIndex:1] == (complex float)2.0f, @"Data multiply failed" );
    STAssertTrue( [a componentAtIndex:2] == (complex float)2.0f, @"Data multiply failed" );    
    STAssertTrue( [a componentAtIndex:3] == (complex float)2.0f, @"Data multiply failed" );
}

- (void)testMismatchedLengths
{
    SMUGComplexVector    *a = [SMUGComplexVector complexVectorWithLength:4];
    SMUGComplexVector    *b = [SMUGComplexVector complexVectorWithLength:5];
    SMUGRealVector           *c = [SMUGRealVector realVectorWithLength:5];
    
    STAssertThrows( [a multiplyBy:c], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [a complexMultiplyBy:b], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [a divideBy:c], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [a complexDivideBy:b], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [a add:c], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [a complexAdd:b], @"Did not throw exception for mismatched lengths" );
}

- (void)testInversion
{
    SMUGComplexVector    *a = [SMUGComplexVector complexVectorWithLength:4];

    [a setComponent:2.0f atIndex:0];
    [a setComponent:2.0f atIndex:1];
    [a setComponent:2.0f atIndex:2];
    [a setComponent:2.0f atIndex:3];

    [a invert];

    STAssertTrue( [a componentAtIndex:0] == (complex float)0.5f, @"Scalar multiply failed" );
    STAssertTrue( [a componentAtIndex:1] == (complex float)0.5f, @"Scalar multiply failed" );
    STAssertTrue( [a componentAtIndex:2] == (complex float)0.5f, @"Scalar multiply failed" );    
    STAssertTrue( [a componentAtIndex:3] == (complex float)0.5f, @"Scalar multiply failed" );
}

@end
