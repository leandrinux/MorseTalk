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
    IBOutlet UITextField *input;
    IBOutlet UITextView *output;
    LvTranslator *translator;
    LvModulator *modulator;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    translator = [[LvTranslator alloc] init];
    modulator = [[LvModulator alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc {
    [translator release];
    [modulator release];
    [super dealloc];
}

- (IBAction)playText:(id)sender {
    NSString *morseText = [translator textToMorse:input.text];
    NSLog(@"%@ -> %@", input.text, morseText);
    output.text = morseText;
    [modulator addMorseInput:morseText];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) || (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
