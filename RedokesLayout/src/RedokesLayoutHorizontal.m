//
//  HboxLayout.m
//  TestApp
//
//  Created by Jared Lewis on 6/26/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import "RedokesLayoutHorizontal.h"
#import "RedokesLayoutBox.h"
#import "RedokesLayoutConfig.h"

@implementation RedokesLayoutHorizontal

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    int itemCount = [items count];
    CGRect viewSize = [self bounds];
    NSLog(@"width=%f, height=%f", self.bounds.size.width, self.bounds.size.height);
    int availableWidth = viewSize.size.width - (padding.left + padding.right);
    int flexWidth = availableWidth;
    int x = padding.left;
    int y = padding.top;
    int i = 0;
    int maxFlex = 0;
    int totalFlex = 0;
    int maxHeight = 0;
    int totalWidth = 0;
    
    //Compute all information about the items
    for (i = 0; i < itemCount; i++){
        //Get the item config
        RedokesLayoutConfig * config = [itemConfigs objectAtIndex:i];
        
        //Compute the max flex
        if(config.flex >= maxFlex){
            maxFlex = config.flex;
        }
        
        //Compute the flexwidth
        if(config.width == 0){
            totalFlex = totalFlex + config.flex;
        }
        else{
            flexWidth -= config.width;
            totalWidth += config.width;
        }
        
        //Compute the maxheight
        if(config.height > maxHeight){
            maxHeight = config.height;
        }
    }
    //NSLog(@" widthRemaining=%d, flexWidth=%d, totalFlex=%d", widthRemaining, flexWidth, totalFlex);
    
    //Determine if we need to pack the items
    if(totalFlex == 0 && totalWidth < availableWidth){
        if(self.pack == @"center"){
            y += (availableWidth - totalWidth) / 2;
        }
        if(self.pack == @"end"){
            y += (availableWidth - totalWidth);
        }
    }
    
    //Draw all the items in this view
    for (i = 0; i < itemCount; i++){
        //Get the item
        UIView *item = [items objectAtIndex:i];
        
        //Get the item config
        RedokesLayoutConfig * config = [itemConfigs objectAtIndex:i];
        
        //Compute the x and y
        int itemX = x + config.margin.left;
        int itemY = y + config.margin.top;
        
        //Compute the item width
        int itemWidth = 0;
        if(config.width == 0){
            float flexRatio = (config.flex / (float)totalFlex);
            itemWidth += (int)round((flexWidth * flexRatio));
        }
        else{
            itemWidth += config.width;
        }
        itemWidth -= (config.margin.left + config.margin.right);
        
        //Compute the item height
        int itemHeight = config.height;
        if(self.align == @"stretch"){
            itemHeight = self.bounds.size.height - [[self getPadding] top] - [[self getPadding] bottom] - config.margin.top - config.margin.bottom;
        }
        if(self.align == @"stretchmax"){
            itemHeight = maxHeight;
        }
        if(self.align == @"middle"){
            itemY = y + ((maxHeight - itemHeight) / 2);
        }
        
        //Create the frame for the item
        CGRect frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        
        //Set the items frame
        [item setFrame:frame];
        
        //Reset the x and y
        x = itemX + itemWidth + config.margin.right;
    }
    
    for (i = 0; i < itemCount; i++){
        //Get the item
        UIView *item = [items objectAtIndex:i];
        [item setNeedsDisplay];
    }
}

@end
