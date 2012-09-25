//
//  LvViewController.m
//  MorseTalk
//
//  Created by Leandro Tami on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  References:
//
//  Producing sound tones
//      http://cocoawithlove.com/2010/10/ios-tone-generator-introduction-to.html
//  Getting microphone input 
//      http://developer.apple.com/library/ios/#samplecode/aurioTouch/Introduction/Intro.html
//  Morse code information
//      http://www.learnmorsecode.com/

#import "LvViewController.h"
#import "LvTranslator.h"
#import "LvModulator.h"

@implementation LvViewController {
    IBOutlet UITextView *output;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *carriage;
    
    LvTranslator *translator;
    LvModulator *modulator;
    LvDemodulator *demodulator;
    NSInteger lines;
    CGFloat currentLineWidth;
    BOOL keyboardEnabled;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    keyboardEnabled = YES;
    
    output.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-paper.png"]];
    output.font = [UIFont fontWithName:@"SpecialElite-Regular" size:42.0f];
    scrollView.contentSize = CGSizeMake(480.0f, scrollView.frame.size.height);
    lines = 1;
    
    translator = [[LvTranslator alloc] init];
    modulator = [[LvModulator alloc] init];
    demodulator = [[LvDemodulator alloc] init];
    demodulator.delegate = self;
    [demodulator start];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc {
    [demodulator stop];
    [demodulator release];
    [modulator release];
    [translator release];
    [super dealloc];
}

- (void)gotMorseText:(NSString *)str {
    
    NSString *ch = ([str isEqualToString:@" "])
        ? @" "
        : [translator morseToText:str];
    
    output.text = [output.text stringByAppendingString:ch];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)keyPressed:(UIButton *)sender {
    if (!keyboardEnabled) return;
    keyboardEnabled = NO;
    NSString *key = sender.titleLabel.text;
    NSString *fullText = [output.text stringByAppendingString:key];

    CGFloat charWidth = [key sizeWithFont:output.font].width;

//    CGFloat fullTextWidth = [fullText sizeWithFont:output.font].width;
    currentLineWidth += charWidth;
    
    NSInteger lineCount;
    CGFloat remainingSpace = 480.0f-currentLineWidth;
    NSLog(@"Remaining space %.2f", remainingSpace);
    if (currentLineWidth>460.0f) {
        currentLineWidth = 0;
        lineCount = lines + 1;
    } else
        lineCount = lines;
    
//    NSInteger lineCount = fullText.length / 18;
    
    [UIView animateWithDuration:.1f animations:^{
        carriage.frame = CGRectMake(carriage.frame.origin.x, 111.0f, 132.0f, 47.0f);
    } completion:^(BOOL finished) {
        output.text = fullText;
        [UIView animateWithDuration:.1f animations:^{
            carriage.frame = CGRectMake(carriage.frame.origin.x, 144.0f, 132.0f, 47.0f);
        } completion:^(BOOL finished) {

//            if (lineCount>lines) {
            if (remainingSpace<=20.0f) {
                
                lines = lineCount;
                NSLog(@"New line!");
                
                float newLineOffset = 42.0f;
                NSLog(@"output height: %.2f", output.frame.size.height + newLineOffset);
                output.frame = CGRectMake(output.frame.origin.x, output.frame.origin.y,
                                          480.0f, output.frame.size.height + newLineOffset);
                
                NSLog(@"scroll height: %.2f", scrollView.contentSize.height + newLineOffset);
                scrollView.contentSize = CGSizeMake(480.0f, scrollView.contentSize.height + newLineOffset);
                
                [UIScrollView animateWithDuration:.3f animations:^{
                    scrollView.contentOffset = CGPointMake(0, newLineOffset * (lines-1));
                    carriage.frame = CGRectMake(-44.0f, 111.0f, 132.0f, 47.0f);
                    keyboardEnabled = YES;
                }];
                
            } else {
                
                [UIScrollView animateWithDuration:.3f animations:^{
                    CGFloat xOffset = carriage.frame.origin.x + charWidth;
                    carriage.frame = CGRectMake(xOffset, carriage.frame.origin.y, 132.0f, 47.0f);
                } completion:^(BOOL finished) {
                    keyboardEnabled = YES;
                }];
            }
            
        }];
    }];
    
    NSString *morseText = [translator textToMorse:key];
//    NSLog(@"%@ -> %@", key, morseText);
    [modulator addMorseInput:morseText];
}

@end
