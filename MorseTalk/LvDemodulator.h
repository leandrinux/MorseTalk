//
//  LvDemodulator.h
//  MorseTalk
//
//  Created by Leandro Tami on 8/11/12.
//
//

#import <Foundation/Foundation.h>

@protocol LvDemodulatorDelegate
- (void)gotMorseText:(NSString *)str;
@end

@interface LvDemodulator : NSObject

@property (nonatomic, assign) NSObject <LvDemodulatorDelegate> *delegate;

- (void)start;
- (void)stop;

@end
