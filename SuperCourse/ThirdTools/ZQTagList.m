//
//  ZQTagList.m
//  yousheng
//
//  Created by Zery on 15/2/2.
//  Copyright (c) 2015年 张洋. All rights reserved.
//

#import "ZQTagList.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS 0.0f
#define LABEL_MARGIN 7.0f
#define BOTTOM_MARGIN 14.0f
#define HORIZONTAL_PADDING 14.0f
#define VERTICAL_PADDING 8.0f
#define BACKGROUND_COLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define TEXT_COLOR UIColorFromRGB(0x666666)
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define BORDER_COLOR UIColorFromRGB(0xcccccc).CGColor
#define BORDER_WIDTH 0.5f

@implementation ZQTagList
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:_view];
    }
    return self;
}

- (void)setTags:(NSArray *)array
{
    self.textArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < array.count; i ++) {
        [self.textArray addObject: [array objectAtIndex:i]];
    }
    sizeFit = CGSizeZero;
    [self display];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    lblBackgroundColor = color;
    [self display];
}

- (void)display
{
    for (UILabel *subview in [self subviews]) {
        
        [subview removeFromSuperview];
        
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    CGSize boundSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);

    for (NSString *text in self.textArray) {

        CGSize textSize =  [text boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:45],NSFontAttributeName, nil] context:nil].size;
        
        textSize.width += HORIZONTAL_PADDING * 2;
        textSize.height += VERTICAL_PADDING * 2;

        UIButton *button = nil;
        [button.layer setBorderWidth:3];
        button.selected = NO;
        if (!gotPreviousFrame) {
            
            button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
            
        } else {
            
            CGRect newRect = CGRectZero;
            
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
                
            } else {
                
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
                
            }
            
            newRect.size = textSize;
            button = [[UIButton alloc] initWithFrame:newRect];
        }
       
        previousFrame = button.frame;
        gotPreviousFrame = YES;

        button.titleLabel.font = [UIFont systemFontOfSize:35*WidthScale];
        
        if (!lblBackgroundColor) {

            [button setBackgroundColor:[UIColor whiteColor]];
            
        } else {
            
            [button setBackgroundColor:lblBackgroundColor];
            
        }
        
        [button setTitle:text forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.layer setMasksToBounds:YES];
        
        [button.layer setCornerRadius:CORNER_RADIUS];
        [button.layer setBorderColor:[UIColor clearColor].CGColor];
        [button.layer setBorderWidth: 2];
        
        [button addTarget:self action:@selector(searchButtonClicke:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);

}


- (void)searchButtonClicke:(id)sender {
    
    [self.delegate searchThis:sender];
}

- (CGSize)fittedSize {
    
    return sizeFit;
    
}

@end
