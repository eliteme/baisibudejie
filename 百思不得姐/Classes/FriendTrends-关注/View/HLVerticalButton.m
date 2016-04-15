//
//  HLVerticalButton.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/15.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "HLVerticalButton.h"

@implementation HLVerticalButton


- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)awakeFromNib
{
    [self setUp];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height- self.titleLabel.y;
    
}

@end
