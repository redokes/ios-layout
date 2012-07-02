//
//  TestController.m
//  TestApp
//
//  Created by Jared Lewis on 6/28/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import "TestController.h"
#import "TestLayout.h"

@implementation TestController

- (id)init
{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)loadView
{
    //Create the main layout
    CGRect frame = [[UIScreen mainScreen] bounds];
    TestLayout * view = [[TestLayout alloc] initWithFrame:frame]; 
    [self setView:view];
}

@end
