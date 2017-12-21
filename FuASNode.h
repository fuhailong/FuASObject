//
//  FuASNode.h
//  MiaoMiaoZheApp
//
//  Created by 付海龙 on 2017/12/4.
//  Copyright © 2017年 付海龙. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ASDisplayNode (Public)

/*
 圆角 + 描边
 */
- (void)maskNodeBound:(CGFloat)borderWidth radius:(CGFloat)radius bordercolor:(UIColor *)borderColor;

@end

@interface ASTextNode (Public)
/*
 ASTextNode 设置 textcolor font
 */
- (void)setAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

/*
 ASTextNode 设置 变色字符串
 */
- (void)setAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color subs:(NSArray *)subsText subColor:(UIColor *)subColor;

@end

@interface ASNetworkImageNode (Public)

/*
 初始化ASNetworkImageNode (cache, downloader)
 */
+ (id)imageNode;

/*
 YYWebImage 下载 图片
 */
- (void)setUrlStr:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

@end
