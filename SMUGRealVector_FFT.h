//
//  SMUGRealVector_FFT.h
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import "SMUGRealVector.h"

@interface SMUGRealVector (FFT)

// Performs a real-valued FFT. N/2+1 values are returned, since the FFT results
// for a real-valued input array are symmetric about the nyquist frequency. The
// First element in the array is the DC component.
- (SMUGComplexVector*)fft;

@end