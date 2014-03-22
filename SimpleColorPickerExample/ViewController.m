//
//  ViewController.m
//  SimpleColorPicker
//
//  Created by 能登 要 on 2014/03/22.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "ViewController.h"
#import "IDPSimpleColorPaletteController.h"
#import "IDPColorChangeTransition.h"

@interface ViewController () <IDPSimpleColorPaletteControllerDelegate,UIViewControllerTransitioningDelegate>
{
    __weak IBOutlet UIButton *_buttonColor;
    __weak IBOutlet UILabel *_labelColor;
    UIColor *_color;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _color = [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:1.0f];
    [self updateBUttonWithColor:_color];
    
    _labelColor.text = @"#000000";
}

- (void) updateBUttonWithColor:(UIColor *)color
{
    CGSize sizeImage = _buttonColor.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeImage.width ,sizeImage.height ) , NO , [UIScreen mainScreen].scale );
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    {
        //// Color Declarations
//        UIColor* color = [UIColor colorWithRed: 0.895 green: 0.145 blue: 0.145 alpha: 1];
        CGFloat colorHSBA[4];
        [color getHue: &colorHSBA[0] saturation: &colorHSBA[1] brightness: &colorHSBA[2] alpha: &colorHSBA[3]];
        
        UIColor* color2 = [UIColor colorWithHue: colorHSBA[0] saturation: colorHSBA[1] brightness: 0.5 alpha: colorHSBA[3]];
        
        //// Abstracted Attributes
        NSString* textContent = @"Pickup Color ";
        
        
        //// Rounded Rectangle Drawing
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(316.5, 84.5, 1, 0) cornerRadius: 0];
        [[UIColor whiteColor] setFill];
        [roundedRectanglePath fill];
        [[UIColor blackColor] setStroke];
        roundedRectanglePath.lineWidth = 1;
        [roundedRectanglePath stroke];
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(3.5, 3.5, 93, 93)];
        [color setFill];
        [rectanglePath fill];
        [color2 setStroke];
        rectanglePath.lineWidth = 1;
        [rectanglePath stroke];
        
        //// Text Drawing
        CGRect textRect = CGRectMake(4, 42, 93, 30);
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [textStyle setAlignment: NSTextAlignmentCenter];
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Light" size: [UIFont systemFontSize]], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: textStyle};
        
        [textContent drawInRect: textRect withAttributes: textFontAttributes];
    }
    
    CGContextRestoreGState(context);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    [_buttonColor setBackgroundImage:image forState:UIControlStateNormal];
    
    UIGraphicsEndImageContext();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)firedPickupColor:(id)sender
{
    IDPSimpleColorPaletteController* colorPaletteController = [[IDPSimpleColorPaletteController alloc] init];
    colorPaletteController.delegate = self;
    
    NSURL *URLWebSafeColor216 = [[NSBundle mainBundle] URLForResource:@"websafecolor216" withExtension:@"plist"];
    NSDictionary *dicWebSafeColor216 = [NSDictionary dictionaryWithContentsOfURL:URLWebSafeColor216];
    
    NSURL *URLNES = [[NSBundle mainBundle] URLForResource:@"nes" withExtension:@"plist"];
    NSDictionary *dicURLNES = [NSDictionary dictionaryWithContentsOfURL:URLNES];
    
    colorPaletteController.colorPatterns = @[dicWebSafeColor216,dicURLNES];
    
    
    
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:colorPaletteController];
    navController.transitioningDelegate = self;
    
    [self presentViewController:navController animated:YES completion:^{
       
    }];
}


#pragma SimpleColorPaletteController delegath method(s)

- (void) IDPSimpleColorPaletteControllerDidSelectColor:(UIColor *)color colorString:colorString
{
    _color = color;
    _labelColor.textColor = _color;
    _labelColor.text = colorString;
    [self updateBUttonWithColor:_color];
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}

- (void) IDPSimpleColorPaletteControllerDidCacel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate
/*
 アニメーションコントローラを返すメソッド（モーダルビュー表示）
 */
- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return nil;
}


/*
 アニメーションコントローラを返すメソッド（モーダルビュー消去）
 */
- (id <UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController *)dismissed
{
    IDPColorChangeTransition *colorChangeTransition = [[IDPColorChangeTransition alloc] init];
    colorChangeTransition.color = _color;
    
    return colorChangeTransition;
}

@end
