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
    NSDictionary *ttm;
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

        ttm = [[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                    @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",
                                                    @"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",
                                                    @"U",@"V",@"W",@"X",@"Y",@"Z",@"1",@"2",@"3",@"4",
                                                    @"5",@"6",@"7",@"8",@"9",@"0",@" ", nil]
                                           forKeys:[NSArray arrayWithObjects:
                                                    @".-",@"-...",@"-.-.",@"-..",@".",@"..-.",@"--.",@"....",@"..",@".---",
                                                    @"-.-",@".-..",@"--",@"-.",@"---",@".--.",@"--.-",@".-.",@"...",@"-",
                                                    @"..-",@"...-",@".--",@"-..-",@"-.--",@"--..",@".----",@"..---",@"...--",@"....-",
                                                    @".....",@"-....",@"--...",@"---..",@"----.",@"-----",@"/", nil]] retain];
    }
    return self;
}

- (void)dealloc {
    [mtt release];
    [super dealloc];
}

- (NSString *)morseToText:(NSString *)morseText {
    NSMutableString *output = [[[NSMutableString alloc] init] autorelease];
    NSArray *morseChars = [morseText componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" /"]];
    for (NSString *morseChar in morseChars) {
        NSString *ch = [ttm objectForKey:morseChar];
        if (ch)
            [output appendString:ch];
        else
            NSLog(@"Unknown morse char: %@", morseChar);
    }
    return output;
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
