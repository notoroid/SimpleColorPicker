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
@property(assign,nonatomic) BOOL enabledDeleteColor;

// Utility methods
+ (void) drawPaletteWithColor:(UIColor *)color size:(CGSize)size;
+ (void) drawClearPaletteWithSize:(CGSize)size;
+ (void) drawDeletePaletteWithSize:(CGSize)size;
@end

@protocol IDPSimpleColorPaletteControllerDelegate <NSObject>
- (void) simpleColorPaletteController:(IDPSimpleColorPaletteController *)simpleColorPaletteController didSelectColor:(UIColor *)color colorString:(NSString *)colorString;
- (void) simpleColorPaletteControllerDidCacel:(IDPSimpleColorPaletteController *)simpleColorPaletteController;
@optional
- (void) IDPSimpleColorPaletteControllerDidSelectColor:(UIColor *)color colorString:(NSString *)colorString DEPRECATED_ATTRIBUTE;
- (void) IDPSimpleColorPaletteControllerDidCacel DEPRECATED_ATTRIBUTE;
@end
