//
//  SMUGComplexVector_FFT.m
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import "SMUGComplexVector_FFT.h"
#import "kiss_fftr.h"

@implementation SMUGComplexVector (FFT)

- (SMUGRealVector*)ifft 
{
    unsigned int    N = ( [self length] - 1 ) * 2;
    float           scale = 1.0f / (float)N;
    SMUGRealVector  *ret = [SMUGRealVector realVectorWithLength:N];
    kiss_fftr_cfg   fftConfig = kiss_fftr_alloc( N, 1, NULL, NULL );
    kiss_fftri( fftConfig, (kiss_fft_cpx*)[self components], [ret components] );
    kiss_fftr_free( fftConfig );
    [ret scaleBy:scale];
    return ret;
}

@end
