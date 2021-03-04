//
//  ZHCButton.m
//  HungryTools
//
//  Created by 张海川 on 2021/1/11.
//

#import "ZHCButton.h"

@interface ZHCButton()

@property (nonatomic, assign) CGRect newImageRect;
@property (nonatomic, assign) CGRect newTitleRect;

@end

@implementation ZHCButton

+ (instancetype)buttonwithAlignment:(ZHCButtonAlignment)alignment {
    ZHCButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.zhc_alignment = alignment;
    
    return button;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    
    if (_zhc_alignment < 2) {       // 水平布局
        size.width += _zhc_spacing + _zhc_padding.left + _zhc_padding.right;
        size.height += _zhc_padding.top + _zhc_padding.bottom;
    } else {                        // 垂直布局
        if (!CGRectIsEmpty(_newImageRect) || !CGRectIsEmpty(_newImageRect)) {
            CGFloat maxWidth = MAX(_newImageRect.size.width, _newTitleRect.size.width);
            
            size.width = _zhc_padding.left + maxWidth + _zhc_padding.right;
            size.height = _zhc_padding.top + _newImageRect.size.height + _zhc_spacing + _newTitleRect.size.height + _zhc_padding.bottom;
        }
    }

    return size;
}

- (void)config {
    _zhc_alignment = ZHCButtonAlignmentHorizontal;
    _zhc_spacing = 10;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return _newImageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    [self calculateImageRectAndTitleRectForContentRect:contentRect];
    return _newTitleRect;
}

- (void)calculateImageRectAndTitleRectForContentRect:(CGRect)contentRect {
    if (CGRectIsEmpty(contentRect)) {
        return;
    }

    CGRect imageRect = [super imageRectForContentRect:contentRect];
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    // 还原真实的title尺寸
    titleRect.size = [self sizeForTitle];
    
    if (_zhc_alignment < 2) {   // 水平布局
        // 加间隔
        imageRect.origin.x -= _zhc_spacing / 2;
        titleRect.origin.x += _zhc_spacing / 2;
        
        // 调整边距
        if (_zhc_padding.left != _zhc_padding.right) {
            CGFloat step = (_zhc_padding.left - _zhc_padding.right) / 2;
            imageRect.origin.x += step;
            titleRect.origin.x += step;
        }
        if (_zhc_padding.top != _zhc_padding.bottom) {
            CGFloat step = (_zhc_padding.top - _zhc_padding.bottom) / 2;
            imageRect.origin.y += step;
            titleRect.origin.y += step;
        }
        
        if (_zhc_alignment == ZHCButtonAlignmentHorizontalReversal) {
            // 交换图片文字位置
            titleRect.origin.x = imageRect.origin.x;
            imageRect.origin.x = CGRectGetMaxX(titleRect) + _zhc_spacing;
        }
        if (CGRectGetMaxX(titleRect) > contentRect.size.width) {
            // X轴超出范围处理
            CGFloat difference = CGRectGetMaxX(titleRect) - contentRect.size.width;
            titleRect.size.width -= difference;
        }
        
        _newImageRect = imageRect;
        _newTitleRect = titleRect;
    } else {                    // 垂直布局
        CGFloat imageHeight = CGRectGetHeight(imageRect);
        CGFloat titleHeight = CGRectGetHeight(titleRect);
        CGFloat imageAndTitleHeight = imageHeight + _zhc_spacing + titleHeight;
        
        CGFloat imageX = CGRectGetMidX(contentRect) - CGRectGetWidth(imageRect) / 2;
        CGFloat imageY = CGRectGetMidY(contentRect) - imageAndTitleHeight / 2;
        CGRect newImageRect = CGRectMake(imageX, imageY, CGRectGetWidth(imageRect), CGRectGetHeight(imageRect));
        
        CGFloat titleX = CGRectGetMidX(contentRect) - CGRectGetWidth(titleRect) / 2;
        CGFloat titleY = CGRectGetMaxY(newImageRect) + _zhc_spacing;
        CGRect newTitleRect = CGRectMake(titleX, titleY, CGRectGetWidth(titleRect), CGRectGetHeight(titleRect));
        
        // 调整边距
        if (_zhc_padding.left != _zhc_padding.right) {
            CGFloat step = (_zhc_padding.left - _zhc_padding.right) / 2;
            newImageRect.origin.x += step;
            newTitleRect.origin.x += step;
        }
        if (_zhc_padding.top != _zhc_padding.bottom) {
            CGFloat step = (_zhc_padding.top - _zhc_padding.bottom) / 2;
            newImageRect.origin.y += step;
            newTitleRect.origin.y += step;
        }
        
        if (_zhc_alignment == ZHCButtonAlignmentVerticalReversal) {
            // 交换图片文字位置
            newTitleRect.origin.y = newImageRect.origin.y;
            newImageRect.origin.y = CGRectGetMaxY(newTitleRect) + _zhc_spacing;
        }
        newTitleRect = [self fixTitleRect:newTitleRect ForContentRect:contentRect];
        _newImageRect = newImageRect;
        _newTitleRect = newTitleRect;
    }
}

- (CGSize)sizeForTitle {
    NSString *title = [self titleForState:self.state];
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : self.titleLabel.font}
                                      context:nil].size;
    return size;
}

- (CGRect)fixTitleRect:(CGRect)titleRect ForContentRect:(CGRect)contentRect {
    if (titleRect.origin.x < 0) {
        titleRect.origin.x = 0;
        titleRect.size.width = contentRect.size.width;
    }
    
    if (CGRectGetMaxY(titleRect) > contentRect.size.height) {
        CGFloat difference = CGRectGetMaxY(titleRect) - contentRect.size.height;
        titleRect.size.height -= difference;
    }
    return titleRect;
}

@end
