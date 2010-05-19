//
//  SMUGRealFFTPlan.h
//  SMUGMath
//
//  Created by Christopher Liscio on 4/19/10.
//  Copyright 2010 SuperMegaUltraGroovy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SMUGRealFFTPlan : NSObject {
    uint32_t mFFTSize;
    void *mForwardPlan;
    void *mInversePlan;
}

- (id)initWithFFTSize:(uint32_t)inFFTSize;

@property (readonly,assign) void *forwardPlan;
@property (readonly,assign) void *inversePlan;
@property (readonly,assign) uint32_t fftSize;

@end
