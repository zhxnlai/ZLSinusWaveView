//
//  SIAudioPlot.m
//  EZAudioRecordExample
//
//  Created by Zhixuan Lai on 8/2/14.
//  Copyright (c) 2014 Syed Haris Ali. All rights reserved.
//

#import "ZLSinusWaveView.h"

@interface ZLSinusWaveView() {
    int tick;
}
@end

@implementation ZLSinusWaveView

@synthesize backgroundColor = _backgroundColor;
@synthesize color           = _color;
@synthesize gain            = _gain;
@synthesize plotType        = _plotType;
@synthesize shouldFill      = _shouldFill;
@synthesize shouldMirror    = _shouldMirror;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    _frequency = 1.5;
    _phase = 0;
    _amplitude = 1.0;
    _whiteValue = 1.0;
    _idleAmplitude = 0.1;
    _dampingFactor = 0.86;
    _waves = 5;
    _waveWidth = 2;
    _phaseShift = -0.15;
    _density = 5.0;
    _maxAmplitude = 0.5;
    _waveInsets = UIEdgeInsetsZero;
}

-(void)_refreshDisplay {
#if TARGET_OS_IPHONE
    [self setNeedsDisplay];
#elif TARGET_OS_MAC
    [self setNeedsDisplay:YES];
#endif
}

- (void)setLeftDecorativeView:(UIView *)leftDecorativeView {
    if (leftDecorativeView) {
        [self addSubview:leftDecorativeView];
    } else {
        [leftDecorativeView removeFromSuperview];
    }
    _leftDecorativeView = leftDecorativeView;
    [self setNeedsLayout];
}

- (void)setRightDecorativeView:(UIView *)rightDecorativeView {
    if (rightDecorativeView) {
        [self addSubview:rightDecorativeView];
    } else {
        [rightDecorativeView removeFromSuperview];
    }
    _rightDecorativeView = rightDecorativeView;
    [self setNeedsLayout];
}

-(void)setSampleData:(float *)data
              length:(int)length {
    
    int requiredTickes = 1; // Alter this to draw more or less often
    tick = (tick+1)%requiredTickes;
    
    // Let's use the buffer's first float value to determine the current sound level.
    float value = fabsf(data[0]);
    
    /// If we defined the current sound level as the amplitude of the wave, the wave would jitter very nervously.
    /// To avoid this, we use an inert amplitude that lifts slowly if the value is currently high, and damps itself
    /// if the value decreases.
    if (value > _dampingAmplitude) _dampingAmplitude += (fmin(value,1.0)-_dampingAmplitude)/4.0;
    else if (value<0.01) _dampingAmplitude *= _dampingFactor;
    
    _phase += _phaseShift;
    _amplitude = fmax( fmin(_dampingAmplitude*20, 1.0), _idleAmplitude);
    
    if (tick==0) {
//        if( plotData != nil ){
//            free(plotData);
//        }
//        
//        plotData   = (CGPoint *)calloc(sizeof(CGPoint),length);
//        plotLength = length;
//        
//        for(int i = 0; i < length; i++) {
//            data[i]     = i == 0 ? 0 : data[i];
//            plotData[i] = CGPointMake(i,data[i] * _gain);
//        }
        
        [self _refreshDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGRect frame = self.bounds;

    // Set the background color
    [(UIColor*)self.backgroundColor set];
    UIRectFill(frame);
    // Set the waveform line color
    [(UIColor*)self.color set];
    
    frame = UIEdgeInsetsInsetRect(self.bounds, self.waveInsets);
    
    // We draw multiple sinus waves, with equal phases but altered amplitudes, multiplied by a parable function.
    for(int i=0;i<_waves+1;i++) {
        
        // [[NSGraphicsContext currentContext] saveGraphicsState];
        CGContextRef context = UIGraphicsGetCurrentContext();
        // CGContextSaveGState(context);
        // CGContextRef context = (CGContextRef) [nsGraphicsContext graphicsPort];
        
        // The first wave is drawn with a waveWidth stroke width, all others a with 1px stroke width.
        CGContextSetLineWidth(context, (i==0)? self.waveWidth:1 );
        
        CGFloat halfHeight = CGRectGetHeight(frame)/2;
        CGFloat width = CGRectGetWidth(frame);
        CGFloat mid = width /2.0;
        
        const CGFloat maxAmplitude = halfHeight*_maxAmplitude-4; // 4 corresponds to twice the stroke width
        
        // Progress is a value between 1.0 and -0.5, determined by the current wave idx, which is used to alter the wave's amplitude.
        CGFloat progress = 1.0-(CGFloat)i/_waves;
        CGFloat normedAmplitude = (1.5*progress-0.5)*_amplitude;
        
        // Choose the color based on the progress (that is, based on the wave idx)
        // [[NSColor colorWithCalibratedWhite:_whiteValue alpha:progress/3.0*2+1.0/3.0] set];
        // [[UIColor colorWithWhite:_whiteValue alpha:progress/3.0*2+1.0/3.0] set];
        
        CGFloat multiplier = MIN(1.0, (progress / 3.0f * 2.0f) + (1.0f / 3.0f));
        [[self.color colorWithAlphaComponent:multiplier * CGColorGetAlpha([UIColor whiteColor].CGColor)] set];
        
        for(CGFloat x = 0; x<width+_density; x+=_density) {
            // We use a parable to scale the sinus wave, that has its peak in the middle of the view.
            CGFloat scaling = -pow(1/mid*(x-mid),2)+1;
            CGFloat y = scaling *maxAmplitude *normedAmplitude *sinf(2 *M_PI *(x / width) *_frequency +_phase) + halfHeight;
            
            CGFloat pointX = CGRectGetMinX(frame)+x; if (pointX != pointX) {pointX = 0;}
            CGFloat pointY = CGRectGetMinY(frame)+y; if (pointY != pointY) {pointY = 0;}
            
            if (x==0) {
                CGContextMoveToPoint(context, pointX, pointY);
            }
            else {
                CGContextAddLineToPoint(context, pointX, pointY);
            }
        }
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(ctx);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = UIEdgeInsetsInsetRect(self.bounds, self.waveInsets);
    
    if (self.leftDecorativeView) {
        self.leftDecorativeView.center = CGPointMake(CGRectGetMinX(frame), CGRectGetMidY(frame));
    }
    
    if (self.rightDecorativeView) {
        self.rightDecorativeView.center = CGPointMake(CGRectGetMaxX(frame), CGRectGetMidY(frame));
    }
}

@end
