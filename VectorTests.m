//
//  FloatDataTests.m
//  SMUGFoundation
//
//  Created by Chris Liscio on 19/07/05.
//  Copyright 2005 SuperMegaUltraGroovy. All rights reserved.
//

#import "VectorTests.h"
#import <SMUGMath/SMUGMath.h>

@implementation VectorTests

- (void)testLength
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:4];
    STAssertTrue( [a length] == 4, @"Unexpected length" );
    [a setLength:8];
    STAssertTrue( [a length] == 8, @"Unexpected length" );
    [a setLength:2];
    STAssertTrue( [a length] == 2, @"Unexpected length" );
    [a setLength:28];
    STAssertTrue( [a length] == 28, @"Unexpected length" );
    
    [a setLength:2048];
    STAssertTrue( [a length] == 2048, @"Unexpected length" );
    [a setComponent:1.0f atIndex:2047];
    STAssertTrue( [a componentAtIndex:2047] == 1.0f, @"Unexpected length" );
    
    [a increaseLengthBy:2048];
    STAssertTrue( [a length] == 4096, @"Unexpected length" );
}

- (void)testReverse
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:8];
    unsigned int    i;
    
    for ( i = 0; i < [a length]; i++ ) {
        [a setComponent:(float)i atIndex:i];
    }
    
    [a reverse];
    
    for ( i = 0; i < [a length]; i++ ) {
        STAssertEquals( [a componentAtIndex:i], (float)([a length]-i-1), @"Values not reversed" );
    }
}

- (void)testRangeCreation
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithIntegersRangingFrom:0 to:7];
    unsigned int    i;
    
    STAssertEquals( [a length], (unsigned int)7, @"Incorrect length" );
    
    STAssertThrows( [a componentAtIndex:7], @"Allowing access beyond range" );
    
    STAssertEquals( [a componentAtIndex:6], (float)6, @"Unexpected last element" );
    
    for ( i = 0; i < [a length]; i++ ) {
        STAssertEquals( [a componentAtIndex:i], (float)(i), @"Range not set right" );
    }
    
    SMUGRealVector  *b = [a copy];
    STAssertEquals( [b length], [a length], @"Copied vector not right" );
    for ( i = 0; i < [b length]; i++ ) {
        STAssertEquals( [b componentAtIndex:i], (float)(i), @"Copied range not set right" );
    }
    [b release];
}

- (void)testCircularShift
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithIntegersRangingFrom:0 to:7];
    unsigned int    i;
    
    [a circularShiftBy:-3];

    for ( i = 0; i < [a length]; i++ ) {
        STAssertEquals( [a componentAtIndex:i], (float)((i+3) % 7), @"Range not shifted left properly" );
    }    
    
    [a circularShiftBy:3];
    
    for ( i = 0; i < [a length]; i++ ) {
        STAssertEquals( [a componentAtIndex:i], (float)(i), @"Range not shifted right properly" );
    }
}

- (void)testSettingFloats
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:4];
    
    [a setComponent:1.0f atIndex:0];
    [a setComponent:1.0f atIndex:1];
    [a setComponent:1.0f atIndex:2];
    [a setComponent:1.0f atIndex:3];
    STAssertThrows( [a setComponent:1.0f atIndex:4], @"Throwing exception failed" );
    
    STAssertEquals( [a componentAtIndex:0], 1.0f, @"Setting component failed" );
    STAssertEquals( [a componentAtIndex:1], 1.0f, @"Setting component failed" );
    STAssertEquals( [a componentAtIndex:2], 1.0f, @"Setting component failed" );    
    STAssertEquals( [a componentAtIndex:3], 1.0f, @"Setting component failed" );
    STAssertThrows( [a componentAtIndex:4], @"Throwing exception failed" );
}

- (void)testSettingRanges
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:8];
    SMUGRealVector  *b = [SMUGRealVector realVectorWithLength:4];
    unsigned int    i;

    for ( i = 0; i < [a length]; i++ ) {
        [a setComponent:1.0f atIndex:i];
    }
    for ( i = 0; i < [b length]; i++ ) {
        [b setComponent:2.0f atIndex:i];
    }

    [a replaceComponentsInRange:NSMakeRange(2, 4) withFloats:[b components]];

    for ( i = 0; i < 2; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 1.0f, @"Setting component range failed" );
    }
    for ( i = 2; i < 6; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 2.0f, @"Setting component range failed" );
    }
    for ( i = 6; i < 8; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 1.0f, @"Setting component range failed" );
    }

    SMUGRealVector  *sd = [a realVectorInRange:NSMakeRange(4,4)];
    STAssertEquals( [sd length], (unsigned int)4, @"Vector subrange has incorrect length" );
    for ( i = 0; i < 2; i++ ) {
        STAssertEquals( [sd componentAtIndex:i], 2.0f, @"Reading float data subrange failed" );
    }
    for ( i = 2; i < 4; i++ ) {
        STAssertEquals( [sd componentAtIndex:i], 1.0f, @"Reading float data subrange failed" );
    }

    [a replaceComponentsInRange:NSMakeRange(0,4) withRealVector:sd];

    for ( i = 0; i < 2; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 2.0f, @"Reading float data subrange failed" );
    }
    for ( i = 2; i < 4; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 1.0f, @"Reading float data subrange failed" );
    }
    for ( i = 4; i < 6; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 2.0f, @"Reading float data subrange failed" );
    }
    for ( i = 6; i < 8; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 1.0f, @"Reading float data subrange failed" );
    }

    STAssertThrows( [a replaceComponentsInRange:NSMakeRange(0,5) withRealVector:sd], @"Did not properly assert exceeding replacement data length" );
    STAssertThrows( [a replaceComponentsInRange:NSMakeRange(5,4) withRealVector:sd], @"Did not properly assert exceeding replacement target length" );
    STAssertThrows( [a replaceComponentsInRange:NSMakeRange(5,4) withFloats:[sd components]], @"Did not properly assert exceeding replacement target length" );
}

- (void)testScalarMultiplies
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:4];
    unsigned int    i;
    
    for ( i = 0; i < [a length]; i++ ) {
        [a setComponent:1.0f atIndex:i];
    }
    
    [a scaleBy:2.0f];
    
    for ( i = 0; i < [a length]; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 2.0f, @"Scalar multiply failed" );
    }
}

- (void)testDataMultiplies
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:4];
    SMUGRealVector  *b = [SMUGRealVector realVectorWithLength:4];
    unsigned int    i;
    
    for ( i = 0; i < [a length]; i++ ) {
        [a setComponent:1.0f atIndex:i];
    }
    for ( i = 0; i < [b length]; i++ ) {
        [b setComponent:2.0f atIndex:i];
    }
    
    [a multiplyBy:b];
    
    for ( i = 0; i < [a length]; i++ ) {
        STAssertEquals( [a componentAtIndex:i], 2.0f, @"Scalar multiply failed" );
    }
}

- (void)testMismatchedLengths
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:4];
    SMUGRealVector  *b = [SMUGRealVector realVectorWithLength:5];

    STAssertThrows( [a multiplyBy:b], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [b multiplyBy:a], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [a divideBy:b], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [b divideBy:a], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [a add:b], @"Did not throw exception for mismatched lengths" );
    STAssertThrows( [b add:a], @"Did not throw exception for mismatched lengths" );
}

- (void)testInversion
{
    SMUGRealVector  *a = [SMUGRealVector realVectorWithLength:4];

    [a setComponent:2.0f atIndex:0];
    [a setComponent:2.0f atIndex:1];
    [a setComponent:2.0f atIndex:2];
    [a setComponent:2.0f atIndex:3];
    
    [a invert];
    
    STAssertEquals( [a componentAtIndex:0], 0.5f, @"Scalar multiply failed" );
    STAssertEquals( [a componentAtIndex:1], 0.5f, @"Scalar multiply failed" );
    STAssertEquals( [a componentAtIndex:2], 0.5f, @"Scalar multiply failed" );    
    STAssertEquals( [a componentAtIndex:3], 0.5f, @"Scalar multiply failed" );
}



- (void)testRMS
{
    SMUGRealVector  *v = [SMUGRealVector realVectorWithComponents:3, 2.0, 2.0, 2.0];
    SMUGRealVector  *w = [SMUGRealVector realVectorWithComponents:3, 2.0, 2.0, 2.0];
    float rms = [v RMSAverage];
    STAssertEquals( rms, 2.0f, @"RMS Average doesn't match up" );
    SMUGRealVector  *x = [SMUGRealVector RMSAverageOfVectors:[NSArray arrayWithObjects:v, w, nil]];
    unsigned int i;
    STAssertEquals( [x length], 3u, @"result RMS averaged vector has bad length" );
    for ( i = 0; i < [x length]; i++ ) {
        STAssertEquals( [x componentAtIndex:i], 2.0f, @"Expected RMS average bad at index %d", i );
    }
}

- (void)testSquare
{
    SMUGRealVector  *v = [SMUGRealVector realVectorWithComponents:10, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0];
    SMUGRealVector  *s = [SMUGRealVector realVectorWithComponents:10, 1.0, 4.0, 9.0, 16.0, 25.0, 36.0, 49.0, 64.0, 81.0, 100.0];
    unsigned int    i;
    
    [v square];
    for ( i = 0; i < 10; i++ ) {
        STAssertEquals( [v componentAtIndex:i], [s componentAtIndex:i], @"Expected square not matched" );
    }
}

- (void)testSum
{
    SMUGRealVector  *v = [SMUGRealVector realVectorWithComponents:10, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
    STAssertEquals( [v cumsum], 10.0f, @"Expected cumulative sum not matched" );
}

- (void)testAdditionSubtraction
{
    SMUGRealVector *v1 = [SMUGRealVector onesWithLength:5];
    SMUGRealVector *v2 = [SMUGRealVector onesWithLength:5];
    [v1 add:v2];
    for ( unsigned int i = 0; i < [v1 length]; i++ ) {
        STAssertEquals( [v1 componentAtIndex:i], (float)2, @"Addition failure" );
    }
    [v1 subtract:v2];
    for ( unsigned int i = 0; i < [v1 length]; i++ ) {
        STAssertEquals( [v1 componentAtIndex:i], (float)1, @"Addition failure" );
    }    
    [v1 subtract:v2];
    for ( unsigned int i = 0; i < [v1 length]; i++ ) {
        STAssertEquals( [v1 componentAtIndex:i], (float)0, @"Addition failure" );
    }        
}


- (void)testResampling
{
    SMUGRealVector *a = [SMUGRealVector realVectorWithComponents:8, 0., 1., 2., 3., 4., 5., 6., 7.];
    SMUGRealVector *b = [SMUGRealVector realVectorWithComponents:8, 0., 1., 2., 3., 4., 5., 6., 7.];    
    SMUGRealVector *aus = [SMUGRealVector realVectorWithComponents:16, 0., 0., 1., 0., 2., 0., 3., 0., 4., 0., 5., 0., 6., 0., 7., 0.];
    
    [a upsampleBy:2];
    
    STAssertEquals( [a length], [aus length], @"Upsampled vector length not matched." );    
    
    unsigned int i;
    for ( i = 0; i < [aus length]; i++ ) {
        STAssertEquals( [aus componentAtIndex:i], [a componentAtIndex:i], @"Upsampled vector not matched." );
    }
    
    [a downsampleBy:2 withOffset:0];
    
    for ( i = 0; i < [a length]; i++ ) {
        STAssertEquals( [b componentAtIndex:i], [a componentAtIndex:i], @"Upsampled vector not matched." );
    }    
}

- (void)testOverlapAdd
{
    SMUGRealVector *ones = [SMUGRealVector onesWithLength:16];
    SMUGRealVector *result = [SMUGRealVector onesWithLength:64];

    for ( int i = 0; i < 7; i++ ) {
        [result overlapAddRealVector:ones atComponent:(i*8)];
    }
    
    for ( int i = 0; i < 8; i++ ) {
        STAssertEquals( [result componentAtIndex:i], 2.0f, @"Components not equal" );
    }
    for ( int i = 8; i < 56; i++ ) {
        STAssertEquals( [result componentAtIndex:i], 3.0f, @"Components not equal" );
    }
    for ( int i = 56; i < 64; i++ ) {
        STAssertEquals( [result componentAtIndex:i], 2.0f, @"Components not equal" );
    }    
}

- (void)testCopyfreeRange
{
    SMUGRealVector *ramp = [SMUGRealVector realVectorWithIntegersRangingFrom:0 to:16];
    for ( int i = 0; i < 16; i++ ) {
        STAssertEquals( [ramp componentAtIndex:i], (float)i, @"Components not equal" );
    }    
    SMUGRealVector *rampRange = [ramp realVectorInRangeNoCopy:NSMakeRange( 0, 4 )];
    for ( int i = 0; i < 4; i++ ) {
        STAssertEquals( [rampRange componentAtIndex:i], (float)i, @"Components not equal" );
    }    
    rampRange = [ramp realVectorInRangeNoCopy:NSMakeRange( 4, 4 )];
    for ( int i = 0; i < 4; i++ ) {
        STAssertEquals( [rampRange componentAtIndex:i], (float)(4+i), @"Components not equal" );
    }
}

- (void)testCopyfreeAdditionRange
{
    NSMutableData *od = [[NSMutableData alloc] initWithLength:20];
    NSMutableData *md = [[NSMutableData alloc] initWithBytesNoCopy:([od mutableBytes]+10) length:[od length]-10 freeWhenDone:NO];
    
    NSLog( @"od bytes %p", [od mutableBytes] );
    NSLog( @"md bytes %p", [md mutableBytes] );    

    SMUGRealVector *sixteenOnes = [SMUGRealVector onesWithLength:16];
    SMUGRealVector *eightOnes = [SMUGRealVector onesWithLength:8];
    
    SMUGRealVector *ranged = [sixteenOnes realVectorInRangeNoCopy:NSMakeRange( 4, 8 )];

    [ranged add:eightOnes];

    NSLog( @"ranged %@", ranged );
    NSLog( @"result %@", sixteenOnes );
    NSLog( @"orig %@", eightOnes );
    
    NSLog( @"ranged components %p", ranged.components );
    NSLog( @"sixteenOnes components %p", sixteenOnes.components );
    NSLog( @"difference of %d bytes", ranged.components - sixteenOnes.components );
    
    for ( int i = 0; i < 4; i++ ) {
        STAssertEquals( [sixteenOnes componentAtIndex:i], 1.0f, @"Components not equal" );
    }
    for ( int i = 4; i < 12; i++ ) {
        STAssertEquals( [sixteenOnes componentAtIndex:i], 2.0f, @"Components not equal" );
    }
    for ( int i = 12; i < 16; i++ ) {
        STAssertEquals( [sixteenOnes componentAtIndex:i], 1.0f, @"Components not equal" );
    }        
}

@end
