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

@end

@implementation PlaySoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureAudioToPlay];
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

#pragma mark AVAudio logic
- (void)configureAudioToPlay
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie_quote"
//                                                     ofType:@"mp3"];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
