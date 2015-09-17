//
//  PlaySoundsViewController.h
//  PitchPerfect
//
//  Created by Andres Kwan on 8/30/15.
//  Copyright (c) 2015 Kwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordedAudio.h"

@interface PlaySoundsViewController : UIViewController
typedef NS_ENUM(NSInteger, EAudioEffect)
{
    EAudioEffectDelay,
    EAudioEffectPitch,
    EAudioEffectReverb,
    EAudioEffectSpeed,
};

@property (nonatomic, strong) RecordedAudio *recordedAudio;

- (IBAction)playSlowButton:(UIButton *)sender;
- (IBAction)playFastButton:(UIButton *)sender;
- (IBAction)stopButton:(UIButton *)sender;
- (IBAction)playChipmunkAudio:(UIButton *)sender;

@end
