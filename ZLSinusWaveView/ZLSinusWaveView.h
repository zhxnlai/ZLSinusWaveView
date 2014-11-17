//
//  SIAudioPlot.h
//  EZAudioRecordExample
//
//  Created by Zhixuan Lai on 8/2/14.
//  Copyright (c) 2014 Syed Haris Ali. All rights reserved.
//

#import "EZAudioPlot.h"

@interface ZLSinusWaveView : EZAudioPlot

/// The amplitude that is used when the incoming microphone amplitude is near zero. Setting a value greater 0 provides a more vivid visualization.
@property (assign,nonatomic) float idleAmplitude;

/// The phase of the sinus wave. Default: 0.
@property (assign,nonatomic) float phase;

/// The frequency of the sinus wave. The higher the value, the more sinus wave peaks you will have. Default: 1.5
@property (assign,nonatomic) float frequency;

/// The damping factor that is used to calm the wave down after a sound level peak. Default: 0.86
@property (assign,nonatomic) float dampingFactor;

/// The number of additional waves in the background. The more waves, to more CPU power is needed. Default: 4.
@property (assign,nonatomic) float waves;

/// The stroke width of the first wave.
@property (assign,nonatomic) float waveWidth;

/// The actual amplitude the view is visualizing. This amplitude is based on the microphone's amplitude
@property (assign,nonatomic,readonly) float amplitude;

/// The damped amplitude.
@property (assign,nonatomic,readonly) float dampingAmplitude;

/// The lines are joined stepwise, the more dense you draw, the more CPU power is used. Default: 5.
@property (assign,nonatomic) float density;

/// The phase shift that will be applied with each delivering of the microphone's value. A higher value will make the waves look more nervous. Default: -0.15.
@property (assign,nonatomic) float phaseShift;

/// The white value of the color to draw the waves with. Default: 1.0 (white).
@property (assign,nonatomic) float whiteValue;

/// Set to NO, if you want to stop the view to oscillate.
@property (assign,nonatomic) BOOL oscillating;

/// The maximum amplitude of the waveform in percent of the view height. Default: 0.5 (half).
@property (assign,nonatomic) float maxAmplitude;

/// The wave inset for each edge.
@property (assign,nonatomic) UIEdgeInsets waveInsets;

/// The decoritive views to be placed at the left end of the wave.
@property (strong, nonatomic) UIView *leftDecorativeView;

/// The decoritive views to be placed at the right end of the wave.
@property (strong, nonatomic) UIView *rightDecorativeView;

@end
