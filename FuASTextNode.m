//
//  FuASTextNode.m
//  MiaoMiaoZheApp
//
//  Created by 付海龙 on 2017/12/19.
//  Copyright © 2017年 付海龙. All rights reserved.
//

#import "FuASTextNode.h"

@implementation FuASTextNode

- (id)init
{
    self = [super init];
    if (self) {
        self.lineSpacing = 0.f;
        self.kern = 0.f;
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)addTextLink:(NSString *)string font:(UIFont *)font color:(UIColor *)color block:(NSMutableAttributedString * (^)(NSMutableAttributedString *mutableAttributedString))block
{
    NSDictionary *(^attributes)(UIFont *, UIColor *) = ^(UIFont *font, UIColor *color){
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
        if (color) {
            [mutDict setObject:color forKey:NSForegroundColorAttributeName];
        }
        if (font) {
            [mutDict setObject:font forKey:NSFontAttributeName];
        }
        NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionaryWithDictionary:mutDict];
        [mutableAttributes setObject:@(self.kern) forKey:NSKernAttributeName];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = self.lineSpacing;
        if (self.maximumNumberOfLines == 1) {
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        }
        paragraphStyle.alignment = self.textAlignment;
        
        [mutableAttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
        
        return [NSDictionary dictionaryWithDictionary:mutableAttributes];
    };
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes(font, color)];
    if (block) {
        mutableAttributedString = block(mutableAttributedString);
    }
    self.attributedText = mutableAttributedString;
}

- (void)setLineSpacing:(CGFloat)lineSpacing
{
    _lineSpacing = lineSpacing;
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableDictionary *mutAttributes = [NSMutableDictionary dictionaryWithDictionary:mutableAttributedString.attributes];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    [mutAttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    [mutableAttributedString addAttributes:mutAttributes range:NSMakeRange(0, self.attributedText.string.length)];
    self.attributedText = mutableAttributedString;
}

- (void)setKern:(CGFloat)kern
{
    _kern = kern;
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableDictionary *mutAttributes = [NSMutableDictionary dictionaryWithDictionary:mutableAttributedString.attributes];
    [mutAttributes setObject:@(kern) forKey:NSKernAttributeName];
    [mutableAttributedString addAttributes:mutAttributes range:NSMakeRange(0, self.attributedText.string.length)];
    self.attributedText = mutableAttributedString;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableDictionary *mutAttributes = [NSMutableDictionary dictionaryWithDictionary:mutableAttributedString.attributes];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = textAlignment;
    [mutAttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    [mutableAttributedString addAttributes:mutAttributes range:NSMakeRange(0, self.attributedText.string.length)];
    self.attributedText = mutableAttributedString;
}

- (void)setMaximumNumberOfLines:(NSUInteger)maximumNumberOfLines
{
    super.maximumNumberOfLines = maximumNumberOfLines;
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableDictionary *mutAttributes = [NSMutableDictionary dictionaryWithDictionary:mutableAttributedString.attributes];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (maximumNumberOfLines == 1) {
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    [mutAttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    [mutableAttributedString addAttributes:mutAttributes range:NSMakeRange(0, self.attributedText.string.length)];
    self.attributedText = mutableAttributedString;
}

@end
