//
//  LvTone.h
//  MorseTalk
//
//  Created by Leandro Tami on 8/11/12.
//
//

#import <Foundation/Foundation.h>

@interface LvTone : NSObject {
    
@public
    double frequency;
    double sampleRate;
    double theta;
}

- (void)toggleSound;

@end
