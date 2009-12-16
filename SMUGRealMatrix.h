//
//  SMUGRealMatrix.h
//  Capo
//
//  Created by Christopher Liscio on 11/19/09.
//  Copyright 2009 SuperMegaUltraGroovy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SMUGMath/SMUGRealVector.h>

@interface SMUGRealMatrix : NSObject <NSCopying> {
    SMUGRealVector *mVector;
    uint64_t mRows;
    uint64_t mColumns;
}

- (id)initWithRows:(uint64_t)rows columns:(uint64_t)cols;
- (id)initWithRealVector:(SMUGRealVector*)realVector rows:(uint64_t)rows columns:(uint64_t)cols;

#pragma mark Accessors
@property (readonly,assign) float* components;
@property (readonly,assign) uint64_t rows;
@property (readonly,assign) uint64_t columns;

- (void)setComponent:(float)c atRow:(uint64_t)row column:(uint64_t)col;
- (float)componentAtRow:(uint64_t)row column:(uint64_t)col;

#pragma mark Operations

// Solve Ax=b. Returns the vector x;
- (SMUGRealVector*)solutionWith_b:(SMUGRealVector*)b;

@end
