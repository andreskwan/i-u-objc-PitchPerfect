//
//  RecordedAudio.h
//  PitchPerfect
//
//  Created by Andres Kwan on 9/1/15.
//  Copyright (c) 2015 Kwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordedAudio : NSObject
@property (nonatomic, strong) NSURL *filePathUrl;
@property (nonatomic, strong) NSString *title;
@end
