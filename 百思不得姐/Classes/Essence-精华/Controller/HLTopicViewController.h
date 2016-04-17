//
//  WordViewController.h
//  百思不得姐
//
//  Created by 索留元 on 16/4/16.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HLTopicType) {
    HLTopicTypeAll = 1,
    HLTopicTypePicture = 10,
    HLTopicTypeWord = 29,
    HLTopicTypeVoice = 31,
    HLTopicTypeVideo = 41
};



@interface HLTopicViewController : UITableViewController
/**帖子类型(交给子类去实现）*/
@property (nonatomic, assign) HLTopicType type;
@end
