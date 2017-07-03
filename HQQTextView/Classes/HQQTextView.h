//
//  HQQTextView.h
//  NewWeibo
//
//  Created by 黄强强 on 15/4/13.
//  Copyright (c) 2015年 黄强强. All rights reserved.
//  带有占位符的textView

#import <UIKit/UIKit.h>

@interface HQQTextView : UITextView
/**
 *  占位符
 */
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, weak) UIColor *placeholderColor;

@property (nonatomic, assign) UIEdgeInsets textInset;
@end
