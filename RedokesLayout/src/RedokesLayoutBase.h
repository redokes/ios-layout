//
//  BaseLayout.h
//  TestApp
//
//  Created by Jared Lewis on 6/26/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RedokesLayoutBox;
@class RedokesLayoutConfig;

@interface RedokesLayoutBase : UIView{
    NSMutableArray * items;
    NSMutableArray * itemConfigs;
    CGRect originalFrame;
    RedokesLayoutBox * padding;
    RedokesLayoutBox * margin;
    
}

@property NSString * align;
@property NSString * pack;

- (void)setConfig:(NSMutableDictionary *)config;
- (NSString *)getMethodName:(NSString *)property;
- (id)add:(id)item;
- (id)add:(id)item config:(RedokesLayoutConfig *)config;
- (void)setPadding:(RedokesLayoutBox *)paddingBox;
- (RedokesLayoutBox *)getPadding;
- (void)setMargin:(RedokesLayoutBox *)marginBox;
- (RedokesLayoutBox *)getMargin;

@end