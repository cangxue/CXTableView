//
//  CXTableViewCell.m
//  CXControl
//
//  Created by xiaoma on 17/3/21.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXTableViewCell.h"

@implementation CXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //设置cell的选中颜色
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark － 自定义左滑按钮样式和编辑状态下按钮的样式设置
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
                        img.image=[UIImage imageNamed:@"select-off"];
                    }
                }
            }
        }
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //遍历子视图，找出按钮
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            for (UIButton *btn in subView.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    //更改左滑标签按钮样式
                    if ([btn.titleLabel.text isEqualToString:@"编辑"]) {
                        [btn setTitle:nil forState:UIControlStateNormal];
                        //设置图片
                        [btn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
                    } else if ([btn.titleLabel.text isEqualToString:@"删除"]){
                        [btn setTitle:nil forState:UIControlStateNormal];
                        //设置图片
                        [btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
                    }
                }
            }
        } else if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
            for (UIImageView *imgView in subView.subviews) {
                if ([imgView isKindOfClass:[UIImageView class]]) {
                    if (self.selected) {
                        imgView.image = [UIImage imageNamed:@"select-on"];
                    } else {
                        imgView.image = [UIImage imageNamed:@"select-off"];
                    }
                }
            }
        }
    }
    
}

@end
