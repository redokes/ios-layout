//
//  LayoutBox.m
//  TestApp
//
//  Created by Jared Lewis on 6/26/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import "RedokesLayoutBox.h"

@implementation RedokesLayoutBox

- (id)init:(int)box{
    self = [super init];
    if(self){
        top = box;
        right = box;
        bottom = box;
        left = box;
    }
    return self;
}

@synthesize top;
@synthesize right;
@synthesize bottom;
@synthesize left;

@end
