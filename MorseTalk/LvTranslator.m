//
//  LvTranslator.m
//  MorseTalk
//
//  Created by Leandro Tami on 8/11/12.
//
//

#import "LvTranslator.h"

@implementation LvTranslator {
    NSDictionary *mtt;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        mtt = [[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                   @".-",@"-...",@"-.-.",@"-..",@".",@"..-.",@"--.",@"....",@"..",@".---",
                                                   @"-.-",@".-..",@"--",@"-.",@"---",@".--.",@"--.-",@".-.",@"...",@"-",
                                                   @"..-",@"...-",@".--",@"-..-",@"-.--",@"--..",@".----",@"..---",@"...--",@"....-",
                                                   @".....",@"-....",@"--...",@"---..",@"----.",@"-----",@"/", nil]
                                          forKeys:[NSArray arrayWithObjects:
                                                   @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",
                                                   @"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",
                                                   @"U",@"V",@"W",@"X",@"Y",@"Z",@"1",@"2",@"3",@"4",
                                                   @"5",@"6",@"7",@"8",@"9",@"0",@" ", nil]] retain];
    }
    return self;
}

- (void)dealloc {
    [mtt release];
    [super dealloc];
}

- (NSString *)morseToText:(NSString *)morseText {
    return @"";
}

- (NSString *)textToMorse:(NSString *)plainText {
    plainText = [plainText uppercaseString];
    NSMutableString *output = [[NSMutableString alloc] init];
    NSInteger c = plainText.length;
    for (NSInteger i=0;i<c;i++) {
        NSString *key = [plainText substringWithRange:NSMakeRange(i, 1)];
        NSString *mch = [mtt objectForKey:key];
        if (mch) {
            [output appendString:[mch stringByAppendingString:@" "]];
        }
    }
    NSString *result = [output stringByReplacingOccurrencesOfString:@" / " withString:@"/"];
    [output release];
    return result;
}

@end
