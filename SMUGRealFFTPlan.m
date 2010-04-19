//
//  SMUGRealFFTPlan.m
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import "SMUGRealFFTPlan.h"

@implementation SMUGRealFFTPlan

@synthesize fftSize=mFFTSize;
@synthesize forwardPlan=mForwardPlan;
@synthesize inversePlan=mInversePlan;

- (id)initWithFFTSize:(uint32_t)inFFTSize;
{
    if ( !( self = [super init] ) ) {
        return nil;
    }
    
    mFFTSize = inFFTSize;
    mForwardPlan = kiss_fftr_alloc( mFFTSize, 0, NULL, NULL );
    mInversePlan = kiss_fftr_alloc( mFFTSize, 1, NULL, NULL );
    
    return self;
}

- (void)dealloc
{
    kiss_fftr_free( mForwardPlan );
    kiss_fftr_free( mInversePlan );
    [super dealloc];
}

@end
