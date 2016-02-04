//
//  SCExtendView.m
//  SuperCourse
//
//  Created by 刘芮东 on 16/2/2.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCExtendView.h"
//#import "SCExtendView.xib"

@interface SCExtendView ()
@property (strong, nonatomic) IBOutlet UILabel *headLabel;
@property (strong, nonatomic) IBOutlet UILabel *firseLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdLabel;
@property (strong, nonatomic) IBOutlet UILabel *firseLabelText;
@property (strong, nonatomic) IBOutlet UILabel *secondLabelText;
@property (strong, nonatomic) IBOutlet UILabel *thirdLabelText;


@property (strong, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtnClick:(id)sender;
@end


@implementation SCExtendView



- (instancetype)initWithString:(NSString *)title AndDataSource:(SCIntroductionDataSource *)datasource
{
    self = [super init];
    if (self) {
        //self.title=title;
        self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SCExtendView class]) owner:nil options:nil].lastObject;
        [self setTitleFont:self.headLabel];
        self.headLabel.text=[NSString stringWithFormat:@"       %@",title];;
        NSString *firstText;
        for(int i=0; i<datasource.har_des.count;i++){
            SCIntroduction *introduct=datasource.har_des[i];
           // firstText=[firstText stringByAppendingFormat:@"%@",introduct.les_intrdoc];
            NSLog(@"%@",introduct.les_intrdoc);
            NSString *temp = introduct.les_intrdoc;
            NSLog(@"%@", temp);
            firstText=(NSString *)introduct.les_intrdoc;

        }
        self.firseLabelText.text=firstText;
        //datasource.har_des.count
        
        
        
        
        
    }
    return self;
}



-(void)awakeFromNib{

    [self setBoarder:self.secondLabel];
    _backBtn.layer.masksToBounds = YES;
    _backBtn.layer.cornerRadius = 31;
    _backBtn.backgroundColor=UIColorFromRGB(0x6fccdb);
    //self.headLabel.text=self.title;
//    SCIntroduction *introduction=self.datasource.har_des;
//    for (NSObject a in introduction) {
//
//    }
//    self.firseLabelText
}

-(void)setTitleFont:(UILabel *)label{
    label.font=[UIFont systemFontOfSize:30];
}


- (IBAction)backBtnClick:(id)sender {
    [self.delegate returnToMainView];
}



-(void)setBoarder:(UILabel *)label{
    [label.layer setBorderWidth:1];//设置边界的宽度
    [label.layer setBorderColor:UIColorFromRGB(0xeeeeee).CGColor];
}
@end
