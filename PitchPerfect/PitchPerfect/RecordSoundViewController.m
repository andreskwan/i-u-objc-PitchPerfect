//
//  ViewController.m
//  PitchPerfect
//
//  Created by Andres Kwan on 8/28/15.
//  Copyright (c) 2015 Kwan. All rights reserved.
//

#import "RecordSoundViewController.h"
#import "RecordedAudio.h"

@import AVFoundation;

static NSString *const kAudioFileName = @"my_audio";
static NSString *const kAudioFileExtension = @"wav";
static NSString *const kSegueIdentifierForStopRecording = @"stopRecording";

@interface RecordSoundViewController () <AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) RecordedAudio *recordedAudio;
@end

@implementation RecordSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.recordLabel.hidden = YES;
    self.stopButton.hidden  = YES;
    self.recordButton.enabled = YES;
}


- (IBAction)recordAudio:(UIButton *)sender {
    self.recordLabel.hidden = NO;
    self.stopButton.hidden  = NO;
    self.recordButton.enabled = NO;
    self.recordLabel.text = @"recording in progress";
    
    //TODO: Record the user's voice
    //optain the path to the Documents directory
    //---------Path & Name of the file
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
    NSString *recordingName = [kAudioFileName stringByAppendingPathExtension:kAudioFileExtension];
    NSArray *pathArray = @[dirPath, recordingName];
    NSURL *filePath = [NSURL fileURLWithPathComponents:pathArray];

    //---------Record Audio
    /* example of the audio settings dictionary
    //http://www.techotopia.com/index.php/Recording_Audio_on_iOS_7_with_AVAudioRecorder
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    */
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    NSError *errorAudioSession = nil;
    NSError *errorAudioRecorder = nil;
    //should be set before activating the session
    //what means to activate the audio session?
    //what is the category?
    //what is the mode?
    //are the same?
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:&errorAudioSession];
    
    
    self.audioRecorder = [[AVAudioRecorder alloc]initWithURL:filePath
                                                    settings:nil
                                                       error:&errorAudioRecorder];
    self.audioRecorder.delegate = self;
    self.audioRecorder.meteringEnabled = YES;
    [self.audioRecorder record];
}

- (IBAction)stopRecord:(UIButton *)sender {
    self.recordLabel.hidden = YES;
    [self.audioRecorder stop];
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    NSError *errorAudioSession = nil;
    [audioSession setActive:NO
                      error:&errorAudioSession];
}
#pragma mark Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark AVAudioRecorderDelegate
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
    if (flag) {
        //TODO: save the recorded audio
        self.recordedAudio = [RecordedAudio new];
        self.recordedAudio.filePathUrl = self.audioRecorder.url.lastPathComponent;
        //TODO: move to the next scene aka perform segue
        //sender means the UIVC from which the segue depart
        [self performSegueWithIdentifier:kSegueIdentifierForStopRecording
                                  sender: self.recordedAudio];
    }else{
        self.recordButton.enabled = YES;
        self.stopButton.hidden = YES;
    }
}

@end
