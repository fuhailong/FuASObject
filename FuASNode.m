//
//  FuASNode.m
//  MiaoMiaoZheApp
//
//  Created by 付海龙 on 2017/12/4.
//  Copyright © 2017年 付海龙. All rights reserved.
//

#import "FuASNode.h"
#import "FuASYYWebImageManager.h"

@implementation ASDisplayNode (Public)

- (void)maskNodeBound:(CGFloat)borderWidth radius:(CGFloat)radius bordercolor:(UIColor *)borderColor
{
    self.borderColor = [borderColor CGColor];
    self.borderWidth = borderWidth;
    self.cornerRadius = radius;
    self.clipsToBounds = YES;
}

@end

@implementation ASTextNode (Public)

- (void)setAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color
{
    [self setAttributedString:string font:font color:color subs:nil subColor:nil];
}

- (void)setAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color subs:(NSArray *)subsText subColor:(UIColor *)subColor
{
    NSString *newString = IS_NOT_EMPTY(string)?string:@"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (color) {
        [dict setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [dict setObject:font forKey:NSFontAttributeName];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:newString
                                                                                         attributes:dict
                                                   ];
    if (IS_NOT_EMPTY(newString) && subsText && subColor) {
        for (id obj in subsText) {
            NSString *oneStr = nil;
            if ([obj isKindOfClass:[NSNumber class]]) {
                oneStr = [NSString stringWithFormat:@"%@", obj];
            }else if ([obj isKindOfClass:[NSString class]]) {
                oneStr = obj;
            }
            
            if (IS_NOT_EMPTY(oneStr)) {
                NSString *tmpStr = newString;
                NSInteger index = 0;
                while (1) {
                    if ([tmpStr containsString:oneStr]) {
                        NSRange range = [tmpStr rangeOfString:oneStr];
                        range.location += index;
                        if (range.location != NSNotFound) {
                            [attributedString addAttribute:NSForegroundColorAttributeName value:subColor range:range];
                        }
                        tmpStr = [newString substringFromIndex:range.location + range.length];
                        index += range.location + range.length;
                    }else {
                        break;
                    }
                }
            }
        }
    }
    self.attributedText = attributedString;
}

- (void)setAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern textAlignment:(NSTextAlignment)textAlignment subs:(NSArray *)subsText subColor:(UIColor *)subColor
{
    NSString *newString = IS_NOT_EMPTY(string)?string:@"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (color) {
        [dict setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [dict setObject:font forKey:NSFontAttributeName];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:newString
                                                                                         attributes:dict
                                                   ];
    if (IS_NOT_EMPTY(newString) && subsText && subColor) {
        for (id obj in subsText) {
            NSString *oneStr = nil;
            if ([obj isKindOfClass:[NSNumber class]]) {
                oneStr = [NSString stringWithFormat:@"%@", obj];
            }else if ([obj isKindOfClass:[NSString class]]) {
                oneStr = obj;
            }
            
            if (IS_NOT_EMPTY(oneStr)) {
                NSString *tmpStr = newString;
                NSInteger index = 0;
                while (1) {
                    if ([tmpStr containsString:oneStr]) {
                        NSRange range = [tmpStr rangeOfString:oneStr];
                        range.location += index;
                        if (range.location != NSNotFound) {
                            [attributedString addAttribute:NSForegroundColorAttributeName value:subColor range:range];
                        }
                        tmpStr = [newString substringFromIndex:range.location + range.length];
                        index += range.location + range.length;
                    }else {
                        break;
                    }
                }
            }
        }
    }
    self.attributedText = attributedString;
}

@end

@implementation ASButtonNode (Public)

- (void)setAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color forState:(UIControlState)state
{
    NSString *newString = IS_NOT_EMPTY(string)?string:@"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (color) {
        [dict setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [dict setObject:font forKey:NSFontAttributeName];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:newString
                                                                                         attributes:dict
                                                   ];
    [self setAttributedTitle:attributedString forState:state];
}

@end

@implementation ASNetworkImageNode (Public)

+ (id)imageNode
{
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    ASNetworkImageNode *node = [[ASNetworkImageNode alloc] initWithCache:manager downloader:manager];
    return node;
}

- (void)setUrlStr:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage
{
    if ([urlString containsString:@","] && [urlString containsString:@"base64"]) {
        NSString *dataStr = [[urlString componentsSeparatedByString:@","] lastObject];
        NSData *imgData = [[NSData alloc] initWithBase64EncodedString:dataStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.image = [UIImage imageWithData:imgData];
    }else {
        NSURL *url = [NSURL URLWithString:urlString];
        if (placeholderImage) {
            self.defaultImage = placeholderImage;
        }
        self.placeholderEnabled = NO;
//        self.placeholderColor = THEME_COLOR;
//        self.placeholderFadeDuration = 3;
        self.URL = url;
    }
}

@end
