//
//  SMUGRealFFTPlan.h
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "kiss_fftr.h"

@interface SMUGRealFFTPlan : NSObject {
    uint32_t mFFTSize;
    kiss_fftr_cfg mForwardPlan;
    kiss_fftr_cfg mInversePlan;
}

- (id)initWithFFTSize:(uint32_t)inFFTSize;

@property (readonly,assign) kiss_fftr_cfg forwardPlan;
@property (readonly,assign) kiss_fftr_cfg inversePlan;
@property (readonly,assign) uint32_t fftSize;

@end
