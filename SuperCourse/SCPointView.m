//
//  SCPointView.m
//  SuperCourse
//
//  Created by 孙锐 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCPointView.h"
#import "SCtempModel.h"
#import "SCRightView.h"

//@interface SCPointView(){
//    
//}



//@end

@implementation SCPointView

- (instancetype)initWithFrame:(CGRect)frame AndObject:(NSMutableArray *)subTitleArr{
    self = [super init];
    if (self) {
        self.frame = frame;
        [self createCellWithData:subTitleArr];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)createCellWithData:(NSMutableArray *)subTitleArr{
    
//    SCRightView *rightView = [[SCRightView alloc]init];
//    tempModel = rightView.subTitleArr;
    
    CGFloat viewY = 0;
    CGFloat height = 100*HeightScale;

    
    for (int i=0; i<4; i++) {

        UIView *noteView = [[UIView alloc]initWithFrame:CGRectMake(12*WidthScale, viewY, self.width, height)];
        noteView.tag = 1;
        UIButton *hudBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hudBtn.tag = 2;
        hudBtn.frame = CGRectMake(0, 0, noteView.bounds.size.width, noteView.bounds.size.height);
        [hudBtn addTarget:self action:@selector(turnToPoint:) forControlEvents:UIControlEventTouchUpInside];
        [noteView addSubview:hudBtn];
        [noteView setBackgroundColor:[UIColor whiteColor]];
       
    
        SCtempModel *m = subTitleArr[i];
        
        
        UIView *letterView = [[UIView alloc]initWithFrame:CGRectMake(32*WidthScale , 32*HeightScale, 36*WidthScale, 36*HeightScale)];
        letterView.tag = 3;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"B"]];
        imageView.tag = 4;
        imageView.frame = CGRectMake(0, 0, letterView.width, letterView.height);
        UILabel *letterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, letterView.width, letterView.height)];
        letterLabel.tag = 5;
        letterLabel.text = m.letter;
        letterLabel.textAlignment = NSTextAlignmentCenter;
        letterLabel.font = [UIFont systemFontOfSize:20*WidthScale];
        [letterLabel setTextColor:[UIColor blackColor]];
        [letterLabel setBackgroundColor:[UIColor clearColor]];
        [letterView addSubview:imageView];
        [letterView addSubview:letterLabel];
        [noteView addSubview:letterView];
        
        
        
        UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(90*WidthScale, 0, 467*WidthScale, 100*HeightScale)];
        noteLabel.tag = 6;
        noteLabel.font = [UIFont systemFontOfSize:35*WidthScale];
        noteLabel.text = m.title;
        [noteLabel setTextColor:[UIColor blackColor]];
        [noteLabel setBackgroundColor:[UIColor clearColor]];
        [noteView addSubview:noteLabel];
        
        noteView.tag = (int)m.beginTime;
        
        [self addSubview:noteView];
        
        viewY = viewY + height+10*HeightScale;
        
        
        
    }
    
  
    
}

-(void)clearAllSelected{
    
    for (UIView *subTitleView in self.subviews) {
        if( subTitleView.frame.origin.x == 0){
            subTitleView.transform = CGAffineTransformMakeTranslation(0*WidthScale, 0*HeightScale);
            self.currentImageView.image = [UIImage imageNamed:@"B"];
            self.currentLabel.textColor = [UIColor blackColor];
            subTitleView.layer.borderColor = [UIColor clearColor].CGColor;
        }
    }
}

-(void)getCurrentImageViewAndLabel:(UIView *)subTitleView{
    for (UIView *subView in subTitleView.subviews) {
        NSInteger tag = subView.tag;
        switch (tag) {
            case 4:
            {
                self.currentImageView = (UIImageView *)subView;
                break;
            }
            case 6:
            {
                self.currentLabel = (UILabel *)subView;
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)turnToPoint:(UIButton *)sender{
    UIView *subTitleView = sender.superview;
    [self getCurrentImageViewAndLabel:subTitleView];
    [self clearAllSelected];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        CGFloat x = subTitleView.x;
        
        if (x!=0) {
            subTitleView.transform = CGAffineTransformMakeTranslation(-12*WidthScale, 10*HeightScale);
            self.currentImageView.image = [UIImage imageNamed:@"A"];
            self.currentLabel.textColor = UIThemeColor;
            subTitleView.layer.borderColor = UIThemeColor.CGColor;
            subTitleView.layer.borderWidth = 2;
        }
    }];
   
}






@end
