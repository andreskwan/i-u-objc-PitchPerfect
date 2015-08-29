//
//  ViewController.m
//  PitchPerfect
//
//  Created by Andres Kwan on 8/28/15.
//  Copyright (c) 2015 Kwan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@end

@implementation ViewController

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
    
}

- (IBAction)stopRecord:(UIButton *)sender {
    self.recordLabel.hidden = YES;
}
@end
