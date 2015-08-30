//
//  PlaySoundsViewController.m
//  PitchPerfect
//
//  Created by Andres Kwan on 8/30/15.
//  Copyright (c) 2015 Kwan. All rights reserved.
//

#import "PlaySoundsViewController.h"
@import AVFoundation;


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

- (IBAction)playSlowButton:(UIButton *)sender {
    [self.audioPlayer play];
}

#pragma mark Audio 
- (void)configureAudioToPlay
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie_quote"
                                                     ofType:@"mp3"];
    NSURL *urlPath = [NSURL fileURLWithPath:path];
    NSError *error;
    //TODO: identify why it is nil
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPath
                                                             error:&error];
    //TODO:handle this error - read
    //https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorHandling/ErrorHandling.html#//apple_ref/doc/uid/TP40001806-CH201-SW1
    if (!error) {
        
    }else{
        //TODO: handle error
    }
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
