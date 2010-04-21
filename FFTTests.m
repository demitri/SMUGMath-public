//
//  FFTTests.m
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import "FFTTests.h"
#import <SMUGMath/SMUGMath.h>

@implementation FFTTests

- (void)testIdentity
{
    SMUGRealVector *rv = [SMUGRealVector realVectorWithIntegersRangingFrom:0 to:1024];
    SMUGRealVector *ident = [[rv fft] ifft];
    for ( NSUInteger i = 0; i < [rv length]; i++ ) {
        STAssertEqualsWithAccuracy( [rv componentAtIndex:i], [ident componentAtIndex:i], 0.001, @"Components not equal" );
    }
}

- (void)testImpulseFFT
{
    SMUGRealVector          *dirac = [SMUGRealVector realVectorWithLength:8192];
    unsigned int            i = 0;    
    
    [dirac setComponent:1.0f atIndex:0];
    
    STAssertTrue( [dirac componentAtIndex:0] == 1.0f, @"Dirac Mismatch" );
    for ( i = 1; i < [dirac length]; i++ ) {
        STAssertTrue( [dirac componentAtIndex:i] == 0.0f, @"Dirac Mismatch" );
    }
    
    STAssertEquals( [dirac componentAtIndex:1], 0.0f, @"Dirac Mismatch" );    
    
    SMUGComplexVector    *response = [dirac fft];

    for ( i = 0; i < [response length]; i++ ) {
        STAssertTrue( [response componentAtIndex:i] == (1.0f + I * 0.0f), @"Frequency Response Mismatch" );
    }
    
    SMUGRealVector   *impulse = [response ifft];
    STAssertEqualsWithAccuracy( [impulse componentAtIndex:0], 1.0f, 0.001, @"Impulse Mismatch" );
    for ( i = 1; i < [impulse length]; i++ ) {
        STAssertEqualsWithAccuracy( [impulse componentAtIndex:i], 0.0f, 0.001, @"Impulse Mismatch" );
    }
}

@end
