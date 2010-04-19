//
//  SMUGRealVector_FFT.m
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import "SMUGRealVector_FFT.h"
#import "SMUGComplexVector.h"
#import "kiss_fftr.h"

@implementation SMUGRealVector (FFT)

//
// A note about my using kiss_fft:
//
//  Long ago while working w/ FuzzMeasure, I discovered a bug in vecLib's 
//  implementation of the FFT. It'd crash with inputs larger than 256k points
//  (128 points on G3 hardware). So I found kiss_fft and haven't looked back.
//
//  There was also some oddity with the way the vecLib stuff returned the 
//  results (aside from the split representation, which was already somewhat 
//  weird/awkward to work with).
//

- (SMUGComplexVector*)fft
{
    NSUInteger N = [self length];
    if ( N == 0 ) {
        [NSException raise:@"FFTZeroLength" format:@"Tried to perform 0-length FFT"];
    }
    SMUGComplexVector   *ret = [SMUGComplexVector complexVectorWithLength:(N/2)+1];
    kiss_fftr_cfg       fftConfig = kiss_fftr_alloc( N, 0, NULL, NULL );
    kiss_fftr( fftConfig, [self components], (kiss_fft_cpx*)[ret components] );
    kiss_fftr_free( fftConfig );
    return ret;
}

@end
