//
//  IDPSimpleColorPaletteController.h
//  SimpleColorPicker
//
//  Created by 能登 要 on 2014/03/22.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IDPSimpleColorPaletteControllerDelegate;

@interface IDPSimpleColorPaletteController : UITableViewController
- (id) init;
@property(weak,nonatomic) id<IDPSimpleColorPaletteControllerDelegate> delegate;
@property(strong,nonatomic) NSArray *colorPatterns;
@end

@protocol IDPSimpleColorPaletteControllerDelegate <NSObject>

- (void) IDPSimpleColorPaletteControllerDidSelectColor:(UIColor *)color colorString:(NSString *)colorString;
- (void) IDPSimpleColorPaletteControllerDidCacel;
@end
