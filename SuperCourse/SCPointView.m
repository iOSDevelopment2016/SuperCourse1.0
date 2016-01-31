//
//  SCPointView.m
//  SuperCourse
//
//  Created by 孙锐 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCPointView.h"
#import "SCRightView.h"
#import "SCPlayerViewController.h"
#import "SCVideoSubTitleMode.h"


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
    
    CGFloat viewY = 0;
    CGFloat height = 100*HeightScale;
    [self setSubTitlesLetter:subTitleArr];
    for (int i=0; i<subTitleArr.count; i++) {
        SCVideoSubTitleMode *m = subTitleArr[i];
        UIView *noteView = [[UIView alloc]initWithFrame:CGRectMake(12*WidthScale, viewY, self.width, height)];
        [noteView setBackgroundColor:[UIColor whiteColor]];
        UIButton *hudBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hudBtn.frame = CGRectMake(0, 0, noteView.bounds.size.width, noteView.bounds.size.height);
        [hudBtn addTarget:self action:@selector(turnToPoint:) forControlEvents:UIControlEventTouchUpInside];
        [noteView addSubview:hudBtn];
       
        UIView *letterView = [[UIView alloc]initWithFrame:CGRectMake(32*WidthScale , 32*HeightScale, 36*WidthScale, 36*HeightScale)];
        UIImage *image = [UIImage imageNamed:@"B"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        UILabel *letterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, letterView.width, letterView.height)];
        UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(90*WidthScale, 0, 467*WidthScale, 100*HeightScale)];
        [noteView addSubview:imageView];
        [noteView addSubview:[self getLetterViewWithLabel:letterLabel AndView:letterView AndimageView:imageView Andimage:image AndLetter:m.letter]];
        [noteView addSubview:[self getNoteLabel:noteLabel WithText:m.title]];
        [self addSubview:noteView];
        
//        noteView.tag = (int)m.beginTime;
        noteView.tag = m.beginTime;
    
        imageView.tag = 1;
        noteLabel.tag = 2;
        
        viewY = viewY + height+10*HeightScale;
        
        
        
    }
    
  
    
}

-(void)setSubTitlesLetter:(NSMutableArray *)subTitleArr{
    for (int i = 0; i<subTitleArr.count; i++) {
        SCVideoSubTitleMode *subTitle = subTitleArr[i];
        subTitle.letter = [self charString:65+i];
    }
}

-(NSString *)charString:(unichar)ascii{
    NSString *str =[NSString stringWithUTF8String:(char *)&ascii];
    return str;
}


-(void)changeSubTitleViewWithTime:(NSTimeInterval)elapsedTime{
    UIView *subTitleView = nil;
    for (subTitleView in self.subviews) {
        if (subTitleView.tag == (int)elapsedTime) {
            if ( subTitleView.x != 0 ){
                [self clearAllSelected];
                [self getCurrentImageViewAndLabel:subTitleView];
                [self highLightSubTitleView:subTitleView];
            }
        }
    }

}
                          
-(UIView *)getLetterViewWithLabel:(UILabel *)letterLabel AndView:(UIView *)letterView AndimageView:(UIImageView *)imageView Andimage:(UIImage *)image AndLetter:(NSString *)letter{
    
    imageView.frame = CGRectMake(32*WidthScale , 32*HeightScale, 36*WidthScale, 36*HeightScale);
    letterLabel.text = letter;
    letterLabel.textAlignment = NSTextAlignmentCenter;
    letterLabel.font = [UIFont systemFontOfSize:20*WidthScale];
    [letterLabel setTextColor:[UIColor whiteColor]];
    [letterLabel setBackgroundColor:[UIColor clearColor]];
    [letterView addSubview:letterLabel];
    
    return letterView;
}
    
-(UILabel *)getNoteLabel:(UILabel *)noteLabel WithText:(NSString *)text{
    noteLabel.tag = 6;
    noteLabel.font = [UIFont systemFontOfSize:35*WidthScale];
    noteLabel.text = text;
    [noteLabel setTextColor:[UIColor blackColor]];
    [noteLabel setBackgroundColor:[UIColor clearColor]];
   
    return noteLabel;
}

-(void)clearAllSelected{
    
    for (UIView *subTitleView in self.subviews) {
        if( subTitleView.frame.origin.x == 0){
            [self getCurrentImageViewAndLabel:subTitleView];
//            subTitleView.transform = CGAffineTransformMakeTranslation(0*WidthScale, 0*HeightScale);
            subTitleView.transform = CGAffineTransformIdentity;
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
            case 1:
            {
                self.currentImageView = (UIImageView *)subView;
                break;
            }
            case 2:
            {
                self.currentLabel = (UILabel *)subView;
                break;
            }
            default:
                break;
        }
        
    }
}

- (void)highLightSubTitleView:(UIView *)subTitleView {
    CGFloat x = subTitleView.x;
    if( x!=0){
        self.currentImageView.image = [UIImage imageNamed:@"A"];
        self.currentLabel.textColor = UIThemeColor;
        subTitleView.layer.borderColor = UIThemeColor.CGColor;
        subTitleView.layer.borderWidth = 2;
        [UIView animateWithDuration:0.4 animations:^{
            subTitleView.transform = CGAffineTransformMakeTranslation(-12*WidthScale, 10*HeightScale);
        }];
    }
}

- (void)turnToPoint:(UIButton *)sender{
    [self clearAllSelected];
    UIView *subTitleView = sender.superview;
    [self getCurrentImageViewAndLabel:subTitleView];
    [self highLightSubTitleView:subTitleView];
    [self.delegate turnToTime:sender];
    
   
}





@end
