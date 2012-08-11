//
//  LvModulator.m
//  MorseTalk
//
//  Created by Leandro Tami on 8/11/12.
//
//

#import "LvModulator.h"
#import "LvTone.h"

#define t_dot .05f
#define t_dash (3*t_dot)
#define t_bar (7*t_dot)

@implementation LvModulator {
    NSMutableArray *queue;
    LvTone *tone;
}

- (id)init {
    if (self = [super init]) {
        queue = [[NSMutableArray alloc] init];
        tone = [[LvTone alloc] init];
        [NSTimer scheduledTimerWithTimeInterval:t_dot target:self selector:@selector(tick:) userInfo:nil repeats:NO];
    }
    return self;
}

- (void)dealloc {
    [tone release];
    [queue release];
    [super dealloc];
}

- (void)addMorseInput:(NSString *)input {
    NSInteger c = input.length;
    for (NSInteger i=0;i<c;i++) {
        NSString *sign = [input substringWithRange:NSMakeRange(i, 1)];
        [queue addObject:sign];
    }
    
}

- (void)playMorseSign:(NSString *)str {
    NSLog(@"Playing %@", str);
    
    if ([str isEqualToString:@"."]) {

        [self play];
        [self performSelector:@selector(stop) withObject:nil afterDelay:t_dot];
        
    } else if ([str isEqualToString:@"-"]) {

        [self play];
        [self performSelector:@selector(stop) withObject:nil afterDelay:t_dash];

    } else if ([str isEqualToString:@" "]) {
        
        [self performSelector:@selector(tick:) withObject:nil afterDelay:t_dot];

    } else if ([str isEqualToString:@"/"]) {
        
        [self performSelector:@selector(tick:) withObject:nil afterDelay:t_bar];
    }
    
}

- (void)tick:(NSTimer *)sender {
    if (queue.count>0)  {
        NSString *text = [queue objectAtIndex:0];
        [self playMorseSign:text];
        [queue removeObjectAtIndex:0];
    } else {
        [NSTimer scheduledTimerWithTimeInterval:t_dot target:self selector:@selector(tick:) userInfo:nil repeats:NO];
    }
}

- (void)play {
    [tone toggleSound];
}

- (void)stop {
    [tone toggleSound];
    
    // restart timer
    [NSTimer scheduledTimerWithTimeInterval:t_dot target:self selector:@selector(tick:) userInfo:nil repeats:NO];
}

@end
