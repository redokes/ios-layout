//
//  TestLayout.h
//  TestApp
//
//  Created by Jared Lewis on 6/27/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//


#import "RedokesLayout.h"

@interface TestLayout : RedokesLayoutVertical
{
    RedokesLayoutHorizontal * header;
    UIWebView * center;
    RedokesLayoutHorizontal * footer;
}

- (void)initHeader;
- (void)initCenter;
- (void)initFooter;
- (void)loadNooga:(id)sender;

@end
