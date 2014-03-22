//
//  IDPColorChangeTransition.h
//  ImageViewTest
//
//  Created by 能登 要 on 2014/03/22.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPColorChangeTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(strong,nonatomic) UIColor* color;

@end
