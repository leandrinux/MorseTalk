//
//  LvModulator.m
//  MorseTalk
//
//  Created by Leandro Tami on 8/11/12.
//
//

#import "LvModulator.h"
#import "LvTone.h"

#define t_dot 0.3f

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
    [queue addObject:input];
}

- (void)playString:(NSString *)str {
    NSLog(@"playstring %@", str);
    
    NSInteger c = str.length;
    for (NSInteger i=0;i<c;i++) {
        NSString *sign = [str substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"Playing: %@", sign);
    }
}

- (void)tick:(NSTimer *)sender {
    
    if (queue.count>0)  {
        NSString *text = [queue objectAtIndex:0];
        [self playString:text];
        [queue removeObjectAtIndex:0];
    }

    // restart timer
    [sender invalidate];
    [[NSTimer scheduledTimerWithTimeInterval:t_dot target:self selector:@selector(tick:) userInfo:nil repeats:NO] retain];
}

- (void)toggleSound {
    [tone toggleSound];
}


@end
