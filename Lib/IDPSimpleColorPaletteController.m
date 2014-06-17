//
//  IDPSimpleColorPaletteController.m
//  SimpleColorPicker
//
//  Created by 能登 要 on 2014/03/22.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPSimpleColorPaletteController.h"
#import "IDPSimpleColorPaletteCell.h"

static NSInteger s_revision = 0;
static NSDictionary *s_paletteColor = nil;

@interface IDPSimpleColorPaletteController ()
{
    __weak IBOutlet UISegmentedControl *_segment;
    NSInteger _selectedIndex;
    double _contentOffsetY;
}

@end

@implementation IDPSimpleColorPaletteController

- (id) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)firedCancel:(id)sender {
    
    if( [_delegate respondsToSelector:@selector(simpleColorPaletteControllerDidCacel:)] == YES && [_delegate respondsToSelector:@selector(IDPSimpleColorPaletteControllerDidCacel)] != YES ){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [_delegate IDPSimpleColorPaletteControllerDidCacel];
#pragma clang diagnostic pop
    }else{
        [_delegate simpleColorPaletteControllerDidCacel:self];
    }
}

- (IBAction)firedColor:(id)sender
{
    UISegmentedControl* segment = [sender isKindOfClass:[UISegmentedControl class]] ? sender : nil;
    _selectedIndex = segment.selectedSegmentIndex;
    [self updateRepositoryWithUpdate:NO];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateRepositoryWithUpdate:YES];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Cellを登録
    [self.tableView registerClass:[IDPSimpleColorPaletteCell class] forCellReuseIdentifier:@"cellColorPalette"];
    // リソースを登録
    
    if( _colorPatterns == nil ){
        _colorPatterns = @[
                           @{@"name":@"Color"
                             ,@"colors":@[ @"#FFF",@"#CCC",@"#999",@"#666",@"#333",@"#000",@"#303",@"#300",@"#330",@"#030",@"#033",@"#003",@"#606",@"#603",@"#600",@"#630",@"#660",@"#360",@"#060",@"#063",@"#066",@"#036",@"#006",@"#306",@"#909",@"#906",@"#903",@"#900",@"#930",@"#960",@"#990",@"#690",@"#390",@"#090",@"#093",@"#096",@"#099",@"#069",@"#039",@"#009",@"#309",@"#609",@"#C0C",@"#C09",@"#C06",@"#C03",@"#C00",@"#C30",@"#C60",@"#C90",@"#CC0",@"#9C0",@"#6C0",@"#3C0",@"#0C0",@"#0C3",@"#0C6",@"#0C9",@"#0CC",@"#09C",@"#06C",@"#03C",@"#00C",@"#30C",@"#60C",@"#90C",@"#F0F",@"#F0C",@"#F09",@"#F06",@"#F03",@"#F00",@"#F30",@"#F60",@"#F90",@"#FC0",@"#FF0",@"#CF0",@"#9F0",@"#6F0",@"#3F0",@"#0F0",@"#0F3",@"#0F6",@"#0F9",@"#0FC",@"#0FF",@"#0CF",@"#09F",@"#06F",@"#03F",@"#00F",@"#30F",@"#60F",@"#90F",@"#C0F",@"#636",@"#633",@"#663",@"#363",@"#366",@"#336",@"#939",@"#936",@"#933",@"#963",@"#993",@"#693",@"#393",@"#396",@"#399",@"#369",@"#339",@"#639",@"#C3C",@"#C39",@"#C36",@"#C33",@"#C63",@"#C93",@"#CC3",@"#9C3",@"#6C3",@"#3C3",@"#3C6",@"#3C9",@"#3CC",@"#39C",@"#36C",@"#33C",@"#63C",@"#93C",@"#F3F",@"#F3C",@"#F39",@"#F36",@"#F33",@"#F63",@"#F93",@"#FC3",@"#FF3",@"#CF3",@"#9F3",@"#6F3",@"#3F3",@"#3F6",@"#3F9",@"#3FC",@"#3FF",@"#3CF",@"#39F",@"#36F",@"#33F",@"#63F",@"#93F",@"#C3F",@"#969",@"#966",@"#996",@"#696",@"#699",@"#669",@"#C6C",@"#C69",@"#C66",@"#C96",@"#CC6",@"#9C6",@"#6C6",@"#6C9",@"#6CC",@"#69C",@"#66C",@"#96C",@"#F6F",@"#F6C",@"#F69",@"#F66",@"#F96",@"#FC6",@"#FF6",@"#CF6",@"#9F6",@"#6F6",@"#6F9",@"#6FC",@"#6FF",@"#6CF",@"#69F",@"#66F",@"#96F",@"#C6F",@"#C9C",@"#C99",@"#CC9",@"#9C9",@"#9CC",@"#99C",@"#F9F",@"#F9C",@"#F99",@"#FC9",@"#FF9",@"#CF9",@"#9F9",@"#9FC",@"#9FF",@"#9CF",@"#99F",@"#C9F",@"#FCF",@"#FCC",@"#FFC",@"#CFC",@"#CFF",@"#CCF"]}
                           ,@{@"name":@"Retro"
                              ,@"colors":@[@"#FFFFFF",@"#B0B0B0",@"#A0A0A0",@"#787878",@"#000000",@"#2000B0",@"#2800B8",@"#6010A0",@"#982078",@"#B01030",@"#A03000",@"#784000",@"#485800",@"#386800",@"#386C00",@"#306040",@"#305080",@"#4060F8",@"#4040FF",@"#9040F0",@"#D840C0",@"#D84060",@"#E05000",@"#C07000",@"#888800",@"#50A000",@"#48A810",@"#48A068",@"#4090C0",@"#60A0FF",@"#5080FF",@"#A070FF",@"#F060FF",@"#FF60B0",@"#FF7830",@"#FFA000",@"#E8D020",@"#98E800",@"#70F040",@"#70E090",@"#60D0E0",@"#90D0FF",@"#A0B8FF",@"#C0B0FF",@"#E0B0FF",@"#FFB8E8",@"#FFC8B8",@"#FFD8A0",@"#FFF090",@"#C8F080",@"#A0F0A0",@"#A0FFC8",@"#A0FFF0"]
                              }
                           ];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(firedCancel:)];
    
    if( _segment == nil && _colorPatterns.count > 1){
        NSMutableArray* items = [NSMutableArray array];
        for( NSDictionary* dict in _colorPatterns ){
            items[items.count] = [dict[@"name"] description];
        }
        UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:items];
        segment.frame = CGRectMake(.0f, .0f, 128.0f, 30.0f);
        segment.center = self.view.center;
        
        // セグメントの選択が変更されたときに呼ばれるメソッドを設定
        [segment addTarget:self action:@selector(firedColor:) forControlEvents:UIControlEventValueChanged];
        
        segment.backgroundColor = [UIColor clearColor];
        // 背景色を設定
        
        // セグメントをビューに貼付ける
        self.navigationItem.titleView = segment;
        _segment = segment;
    }else if(_colorPatterns.count == 1){
        self.navigationItem.title = [_colorPatterns[0][@"name"] description];
    }
    
    
    _selectedIndex = _colorPatterns.count <= _selectedIndex ? (_colorPatterns.count -1) : _selectedIndex;
    _segment.selectedSegmentIndex = _selectedIndex;
    
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointMake(0, _contentOffsetY);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _colorPatterns.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    
    if( section == _selectedIndex ){
        NSArray* palette = _colorPatterns[section][@"colors"];
        number = (palette.count / 4 + (palette.count % 4 ? 1 : 0));
    }else{
        number = 0;
    }
    
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellColorPalette" forIndexPath:indexPath];
    [self configureCell:cell indexPath:indexPath];
    return cell;
}

typedef void (^ColorPalletURenderBlock)(IDPSimpleColorPaletteCell *cell,UIButton *button,UIColor *color);
;
- (NSArray *)selectedPalletWithIndexPath:(NSIndexPath *)indexPath
{
    NSArray* palette = _colorPatterns[indexPath.section][@"colors"];
    return palette;
}

- (UIColor *)colorWithWebColor:(NSString *)webColor
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
    
    if( webColor.length == 7 ){
        /*double*/ red = ([s_paletteColor[[webColor substringWithRange:NSMakeRange(1, 1)]] doubleValue] * 16
                          + [s_paletteColor[[webColor substringWithRange:NSMakeRange(2, 1)]] doubleValue]) / 255.0f;
        
        /*double*/ green = ([s_paletteColor[[webColor substringWithRange:NSMakeRange(3, 1)]] doubleValue] * 16
                            + [s_paletteColor[[webColor substringWithRange:NSMakeRange(4, 1)]] doubleValue]) / 255.0f;
        
        /*double*/ blue = ([s_paletteColor[[webColor substringWithRange:NSMakeRange(5, 1)]] doubleValue] * 16
                           + [s_paletteColor[[webColor substringWithRange:NSMakeRange(6, 1)]] doubleValue]) / 255.0f;
    }else if(webColor.length == 4){
        /*double*/ red = ([s_paletteColor[[webColor substringWithRange:NSMakeRange(1, 1)]] doubleValue]);
        red = red * 16 + red;
        red /= 255.0f;
        
        /*double*/ green = ([s_paletteColor[[webColor substringWithRange:NSMakeRange(2, 1)]] doubleValue]);
        green = green * 16 + green;
        green /= 255.0f;
        
        /*double*/ blue = ([s_paletteColor[[webColor substringWithRange:NSMakeRange(3, 1)]] doubleValue]);
        blue = blue * 16 + blue;
        blue /= 255.0f;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (void) drawPaletteWithColor:(UIColor *)color size:(CGSize)size
{
    BOOL isWhiteColor = [color isEqual:[UIColor whiteColor]] ? YES : NO;
    
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1];
    //                    UIColor* color = [UIColor colorWithRed: 0.657 green: 0 blue: 0 alpha: 1];
    CGFloat colorHSBA[4];
    [color getHue: &colorHSBA[0] saturation: &colorHSBA[1] brightness: &colorHSBA[2] alpha: &colorHSBA[3]];
    
    UIColor* color3 = isWhiteColor ? [UIColor lightGrayColor] : [UIColor colorWithHue: colorHSBA[0] saturation: colorHSBA[1] brightness: 0.9 alpha: colorHSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(3.5, 3.5, size.width - 3.5 * 2.0f /*71*/,size.height - 3.5 * 2.0f /*71*/)];
    [color2 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(7.5, 7.5, size.width - 7.5 * 2.0f, size.height - 7.5 * 2.0f)];
    [color setFill];
    [oval2Path fill];
    [color3 setStroke];
    oval2Path.lineWidth = 1;
    [oval2Path stroke];
}

- (void) configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    s_revision++;
    NSInteger currentRevision = s_revision;
    
    NSArray *palette = [self selectedPalletWithIndexPath:indexPath];
    
    
    CGSize iconSize = CGSizeMake(78.0f, 78.0f);
    ColorPalletURenderBlock render = ^(IDPSimpleColorPaletteCell *IDPSimpleColorPaletteCell,UIButton *button,UIColor *color){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                const CGFloat scale = [UIScreen mainScreen].scale;
                
                const CGFloat width = ceil(iconSize.width * scale);
                const CGFloat height = ceil(iconSize.height * scale);
                
                CGColorSpaceRef imageColorSpace = CGColorSpaceCreateDeviceRGB();
                CGContextRef context = CGBitmapContextCreate(NULL, width, height,8, width * 4, imageColorSpace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big);
                
                CGContextSaveGState(context);
                
                CGContextTranslateCTM(context, .0f ,height);
                CGContextScaleCTM(context, scale, -scale);
                UIGraphicsPushContext(context);
                {
                    [IDPSimpleColorPaletteController drawPaletteWithColor:color size:iconSize];
                }
                UIGraphicsPopContext();
                
                CGImageRef cgImage = CGBitmapContextCreateImage(context);
                UIImage* palletImage = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:UIImageOrientationUp ];
                CGImageRelease(cgImage);
                
                CGContextRestoreGState(context);
                
                CGContextRelease(context);
                CGColorSpaceRelease(imageColorSpace);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if( IDPSimpleColorPaletteCell.revision == currentRevision ){
                        [button setBackgroundImage:palletImage forState:UIControlStateNormal];
                    }
                });
            }
        });
    };
    
    NSInteger begin = indexPath.row *4;
    NSInteger end = palette.count < (begin + 4) ? palette.count : (begin + 4);
    
    NSArray *buttons = @[[cell viewWithTag:1]
                         ,[cell viewWithTag:2]
                         ,[cell viewWithTag:3]
                         ,[cell viewWithTag:4]
                         ];
    
    NSInteger i;
    for( i = begin; i != end; i++ ){
        IDPSimpleColorPaletteCell *simpleColorPaletteCell = (IDPSimpleColorPaletteCell *)cell;
        simpleColorPaletteCell.revision = currentRevision;
        // リビジョンを登録
        
        UIButton *button = buttons[i-begin];
        NSString *colorString = palette[i];
        render(simpleColorPaletteCell,button,[self colorWithWebColor:colorString] );
        
        [button addTarget:self action:@selector(firedSelectPallet:) forControlEvents:UIControlEventTouchUpInside];
    }
    for( ; i != (begin + 4); i++ ){
        UIButton *button = buttons[i-begin];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button removeTarget:self action:@selector(firedSelectPallet:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) firedSelectPallet:(id)sender
{
    UIButton *button = [sender isKindOfClass:[UIButton class]] ? sender : nil;
    
    NSArray* visibleCells = self.tableView.visibleCells;
    for( UITableViewCell *cell in visibleCells ){
        NSArray *buttons = @[[cell viewWithTag:1]
                             ,[cell viewWithTag:2]
                             ,[cell viewWithTag:3]
                             ,[cell viewWithTag:4]
                             ];
        for( UIButton *compareButton in buttons ){
            if( compareButton == button ){
                
                _contentOffsetY = self.tableView.contentOffset.y + self.tableView.contentInset.top;
                [self updateRepositoryWithUpdate:NO];
                
                NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
                NSInteger begin = indexPath.row *4;
                
                NSInteger index = [buttons indexOfObject:button];
                NSArray *palette = [self selectedPalletWithIndexPath:indexPath];
                NSString *colorString = palette[begin + index];
                
                
                if( [_delegate respondsToSelector:@selector(IDPSimpleColorPaletteControllerDidSelectColor:colorString:)] == YES && [_delegate respondsToSelector:@selector(simpleColorPaletteController:didSelectColor:colorString:)] != YES ){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    [_delegate IDPSimpleColorPaletteControllerDidSelectColor:[self colorWithWebColor:colorString] colorString:colorString];
#pragma clang diagnostic pop
                }else{
                    [_delegate simpleColorPaletteController:self didSelectColor:[self colorWithWebColor:colorString] colorString:colorString];
                }
                
                break;
            }
        }
    }
}

- (void)updateRepositoryWithUpdate:(BOOL) update
{
	NSString* repositoryFileName = @"idpsimplecolorpallet.dat";
    NSString* repositorySelectedIndex = @"SelectedIndex";
    NSString* repositoryContentOffsetY = @"ContentOffsetY";
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	NSString *dataFilepath = /*[*/[documentDirectory stringByAppendingPathComponent:repositoryFileName]/*autorelease]*/;
	//	self.dataFilePath = path;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if( update == YES ){ // 更新
		if ([fileManager fileExistsAtPath:dataFilepath]) {
			NSMutableData *theData  = [NSMutableData dataWithContentsOfFile:dataFilepath];
			NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
            
            _selectedIndex = [decoder decodeIntegerForKey:repositorySelectedIndex];
            _contentOffsetY = [decoder decodeDoubleForKey:repositoryContentOffsetY];
            
			[decoder finishDecoding];
		}else{
            
		}
	}else{ // 反映
		NSMutableData *theData = [NSMutableData data];
		NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
		
        [encoder encodeInteger:_selectedIndex forKey:repositorySelectedIndex];
        [encoder encodeDouble:_contentOffsetY forKey:repositoryContentOffsetY];
        
		[encoder finishEncoding];
		[theData writeToFile:dataFilepath atomically:YES];
	}
}

@end
