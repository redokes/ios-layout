//
//  LayoutConfig.m
//  TestApp
//
//  Created by Jared Lewis on 6/27/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import "RedokesLayoutConfig.h"

@implementation RedokesLayoutConfig

@synthesize margin;
@synthesize flex;
@synthesize width;
@synthesize height;
@synthesize floating;

-(id)init
{
    self = [super init];
    if(self){
        [self setMargin:[[RedokesLayoutBox alloc] init]];
        [self setFlex:1];
        [self setWidth:0];
        [self setHeight:0];
        [self setFloating:NO];
    }
    return self;
}

@end
