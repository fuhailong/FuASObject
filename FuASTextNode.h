//
//  FuASTextNode.h
//  MiaoMiaoZheApp
//
//  Created by 付海龙 on 2017/12/19.
//  Copyright © 2017年 付海龙. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface FuASTextNode : ASTextNode
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat kern;
@property (nonatomic, assign) NSTextAlignment textAlignment;

/*
 ASTextNode 变色 + 链接
 */
- (void)addTextLink:(NSString *)string font:(UIFont *)font color:(UIColor *)color block:(NSMutableAttributedString * (^)(NSMutableAttributedString *mutableAttributedString))block;

@end
