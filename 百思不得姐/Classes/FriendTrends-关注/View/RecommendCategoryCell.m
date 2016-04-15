//
//  RecommendCategoryCell.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/14.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "RecommendCategoryCell.h"
#import "RecommendCategory.h"
@interface RecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation RecommendCategoryCell

- (void)awakeFromNib {
   
//    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = HLRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = HLRGBColor(219, 21, 26);
    
}

- (void)setCategory:(RecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//     self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : XMGRGBColor(78, 78, 78);
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : HLRGBColor(78, 78, 78);
    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.font = [UIFont systemFontOfSize:16];
//    self.contentView.backgroundColor = [UIColor greenColor];
//    self.textLabel.backgroundColor = [UIColor blueColor];
    self.textLabel.y = 5;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
@end
