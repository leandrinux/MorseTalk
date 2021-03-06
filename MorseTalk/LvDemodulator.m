//
//  LvDemodulator.m
//  MorseTalk
//
//  Created by Leandro Tami on 8/11/12.
//
//

#import "LvDemodulator.h"
#import "LvToneDetector.h"

#define interval 1.0f

@implementation LvDemodulator {
    NSTimer *timer;
    LvToneDetector *detector;
}

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        detector = [[LvToneDetector alloc] init];
    }
    return self;
}

- (void)dealloc {
    [detector release];
    [timer invalidate];
    [super dealloc];
}

- (void)start {
    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void)stop {
    [timer invalidate], timer = nil;
}

- (void)tick:(NSTimer *)sender {
    
//    NSLog(@"Demodulator tick");
//    if ([delegate respondsToSelector:@selector(gotMorseText:)])
//        [delegate gotMorseText:@".-"];
    
}

@end
