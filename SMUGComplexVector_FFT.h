//
//  SMUGComplexVector_FFT.h
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import "SMUGComplexVector.h"
#import "SMUGRealVector.h"

@interface SMUGComplexVector (FFT)
// Return the real valued results of a real-value FFT. Returns N elements when
// given N/2+1 elements as input. The result is scaled appropriately so that 
// performing [[aVec fft] ifft] returns the same components that were in aVec.
- (SMUGRealVector*)ifft;
@end
