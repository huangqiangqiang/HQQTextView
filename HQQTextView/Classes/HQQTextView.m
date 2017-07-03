//
//  HQQTextView.m
//  NewWeibo
//
//  Created by 黄强强 on 15/4/13.
//  Copyright (c) 2015年 黄强强. All rights reserved.
//

#import "HQQTextView.h"

@interface HQQTextView ()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation HQQTextView

#define HQQTextViewDefaultPaddingY (7)

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    // 添加placeholderLabel
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.textColor = self.placeholderColor ? self.placeholderColor : [UIColor lightGrayColor];
    placeholderLabel.text = self.placeholder;
    [self addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    
    // 设置默认字体大小
    self.font = [UIFont systemFontOfSize:15];
    
    // 添加监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)setTextInset:(UIEdgeInsets)textInset
{
    _textInset = textInset;
    self.textContainerInset = textInset;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat paddingX = self.textInset.left + 5;
    CGFloat paddingY = self.textInset.top == 0 ? HQQTextViewDefaultPaddingY : self.textInset.top;
    
    CGSize maxSize = CGSizeMake(self.frame.size.width - 2 * paddingX, MAXFLOAT);
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    CGRect frame = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    self.placeholderLabel.frame = CGRectMake(paddingX, paddingY, frame.size.width, frame.size.height);
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = self.text.length;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

/**
 *  设置placeholder
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

/**
 *  设置font大小
 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

@end
