//
//  LvTranslator.h
//  MorseTalk
//
//  Created by Leandro Tami on 8/11/12.
//
//

#import <UIKit/UIKit.h>

@interface LvTranslator : UIView

- (NSString *)morseToText:(NSString *)morseText;
- (NSString *)textToMorse:(NSString *)plainText;

@end
