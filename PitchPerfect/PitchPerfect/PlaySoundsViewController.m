//
//  PlaySoundsViewController.m
//  PitchPerfect
//
//  Created by Andres Kwan on 8/30/15.
//  Copyright (c) 2015 Kwan. All rights reserved.
//

#import "PlaySoundsViewController.h"

@import AVFoundation;


static CGFloat const kAudioPlayerFastRate = 1.5;
static CGFloat const kAudioPlayerSlowRate = 0.5;
static CGFloat const kAudioPlayerStartFromTheBegining = 0.0;


@interface PlaySoundsViewController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioEngine *audioEngine;
@property (nonatomic, strong) AVAudioFile *audioFile;
@end

@implementation PlaySoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureAudioToPlay];
    self.audioEngine = [AVAudioEngine new];
    //used to decode
    self.audioFile = [[AVAudioFile alloc]initForReading:self.recordedAudio.filePathUrl
                                                  error:nil];
    NSLog(@"File URL:          %@\n", self.recordedAudio.filePathUrl.absoluteString);
    NSLog(@"File format:       %@\n", self.audioFile.fileFormat.description);
    NSLog(@"Processing format: %@\n", self.audioFile.processingFormat.description);
    NSLog(@"File lenght: %.3f seconds \n", self.audioFile.length / self.audioFile.fileFormat.sampleRate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark buttons logic
- (IBAction)playSlowButton:(UIButton *)sender {
    [self playAudioWithSpeedRate:kAudioPlayerSlowRate];
}

- (IBAction)playFastButton:(UIButton *)sender {
    [self playAudioWithSpeedRate:kAudioPlayerFastRate];
}

- (IBAction)stopButton:(UIButton *)sender {
    [self.audioPlayer stop];
}

- (IBAction)playChipmunkAudio:(UIButton *)sender {
    [self playAudioWithEffect:EAudioEffectPitch
                  effectValue:@1000.0];
}

#pragma mark AVAudio logic
- (void)configureAudioToPlay
{
    NSURL *urlPath = self.recordedAudio.filePathUrl;
    NSError *error;
    //TODO: identify why it is nil
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPath
                                                             error:&error];
    self.audioPlayer.enableRate = YES;

    //TODO:handle errors - read
    //https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorHandling/ErrorHandling.html#//apple_ref/doc/uid/TP40001806-CH201-SW1
    if (!error) {
        
    }else{
        //TODO: handle error
        
    }
}

- (void)playAudioWithSpeedRate:(CGFloat)audioRate
{
    self.audioPlayer.rate = audioRate;
    self.audioPlayer.currentTime = kAudioPlayerStartFromTheBegining; 
    [self.audioPlayer stop];
    [self.audioPlayer play];
}

#pragma mark Audio Effects
-(void)playAudioWithEffect:(EAudioEffect)audioEffect
               effectValue:(NSNumber*)effectValue
{
    [self.audioPlayer stop];
    [self.audioEngine stop];
    [self.audioEngine reset];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession setCategory:AVAudioSessionCategoryPlayback error:nil]) {
        switch (audioEffect) {
            case EAudioEffectPitch:
                [self playAudioWithVariablePitch:effectValue];
                break;
                
            default:
                break;
        }
    } else {
        
    }
}
-(void)playAudioWithVariablePitch:(NSNumber*)pitch
{
    //TDOO: Handle errors
    NSError *audioEngineError = nil;
    //TODO: this two lines are repeated code should be replaced for a function
    AVAudioPlayerNode *audioPlayerNode = [AVAudioPlayerNode new];
    [self.audioEngine attachNode:audioPlayerNode];
    
    AVAudioUnitTimePitch *timePitchEffect = [AVAudioUnitTimePitch new];
    [self.audioEngine attachNode:timePitchEffect];
    
    timePitchEffect.pitch = [pitch floatValue];
    
    [self.audioEngine connect:audioPlayerNode
                           to:timePitchEffect
                       format:nil];
    [self.audioEngine connect:timePitchEffect
                           to:self.audioEngine.outputNode
                       format:nil];
    
    [audioPlayerNode scheduleFile:self.audioFile
                           atTime:nil
                completionHandler:nil];
    [self.audioEngine startAndReturnError:&audioEngineError];
    if (audioEngineError) {
        NSLog(@"%@",@"pero que es esto che!!!");
    }
    [audioPlayerNode play];
}

@end
