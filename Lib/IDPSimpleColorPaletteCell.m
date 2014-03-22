//
//  IDPSimpleColorPaletteCell.m
//  SimpleColorPicker
//
//  Created by 能登 要 on 2014/03/22.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPSimpleColorPaletteCell.h"

@implementation IDPSimpleColorPaletteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(1.0f, 1.0f, 78.0f, 78.0f)];
        button.tag = 1;
        [self addSubview:button];
        
        /*UIButton **/button = [[UIButton alloc] initWithFrame:CGRectMake(81.0f, 1.0f, 78.0f, 78.0f)];
        button.tag = 2;
        [self addSubview:button];

        /*UIButton **/button = [[UIButton alloc] initWithFrame:CGRectMake(161.0f, 1.0f, 78.0f, 78.0f)];
        button.tag = 3;
        [self addSubview:button];

        /*UIButton **/button = [[UIButton alloc] initWithFrame:CGRectMake(241.0f, 1.0f, 78.0f, 78.0f)];
        button.tag = 4;
        [self addSubview:button];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)prepareForReuse
{
    _revision = 0;
}

@end
