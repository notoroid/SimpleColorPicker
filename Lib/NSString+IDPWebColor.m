//
//  NSString+WebColor.m
//  SimpleColorPicker
//
//  Created by 能登 要 on 2014/03/22.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "NSString+IDPWebColor.h"

static NSDictionary *s_paletteColor = nil;

@implementation NSString (WebColor)

- (UIColor *)color
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_paletteColor = @{  @"0":@0
                          ,@"1":@1
                          ,@"2":@2
                          ,@"3":@3
                          ,@"4":@4
                          ,@"5":@5
                          ,@"6":@6
                          ,@"7":@7
                          ,@"8":@8
                          ,@"9":@9
                          ,@"A":@10
                          ,@"B":@11
                          ,@"C":@12
                          ,@"D":@13
                          ,@"E":@14
                          ,@"F":@15
                    };
    });
    
    double red = .0f;
    double green =  .0f;
    double blue =  .0f;
    
    if( self.length == 7 ){
        /*double*/ red = ([s_paletteColor[[self substringWithRange:NSMakeRange(1, 1)]] doubleValue] * 16
                               + [s_paletteColor[[self substringWithRange:NSMakeRange(2, 1)]] doubleValue]) / 255.0f;
        
        /*double*/ green = ([s_paletteColor[[self substringWithRange:NSMakeRange(3, 1)]] doubleValue] * 16
                                 + [s_paletteColor[[self substringWithRange:NSMakeRange(4, 1)]] doubleValue]) / 255.0f;
        
        /*double*/ blue = ([s_paletteColor[[self substringWithRange:NSMakeRange(5, 1)]] doubleValue] * 16
                                + [s_paletteColor[[self substringWithRange:NSMakeRange(6, 1)]] doubleValue]) / 255.0f;
    }else if(self.length == 4){
        /*double*/ red = ([s_paletteColor[[self substringWithRange:NSMakeRange(1, 1)]] doubleValue] * 16) / 255.0f;
        /*double*/ green = ([s_paletteColor[[self substringWithRange:NSMakeRange(2, 1)]] doubleValue] * 16) / 255.0f;
        /*double*/ blue = ([s_paletteColor[[self substringWithRange:NSMakeRange(3, 1)]] doubleValue] * 16) / 255.0f;
    }
    
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (BOOL) isEqualToColor:(NSString *)color
{
    NSString *compare1 = self;
    if(compare1.length == 4 ){
        compare1 = [NSString stringWithFormat:@"#%@0%@0%@0",[self substringWithRange:NSMakeRange(1, 1)],[self substringWithRange:NSMakeRange(2, 1)],[self substringWithRange:NSMakeRange(1, 1)]];
    }
    
    NSString *compare2 = color;
    if(compare2.length == 4 ){
        compare1 = [NSString stringWithFormat:@"#%@0%@0%@0",[compare2 substringWithRange:NSMakeRange(1, 1)],[compare2 substringWithRange:NSMakeRange(2, 1)],[compare2 substringWithRange:NSMakeRange(1, 1)]];
    }
    
    return [compare1 isEqualToString:compare2];
}

@end
