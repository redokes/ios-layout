//
//  VBoxLayout.m
//  TestApp
//
//  Created by Jared Lewis on 6/27/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import "RedokesLayoutVertical.h"
#import "RedokesLayoutBox.h"
#import "RedokesLayoutConfig.h"

@implementation RedokesLayoutVertical

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    int itemCount = [items count];
    CGRect viewSize = [self bounds];
    NSLog(@"width=%f, height=%f", self.bounds.size.width, self.bounds.size.height);
    int availableHeight = viewSize.size.height - (padding.top + padding.bottom);
    int flexHeight = availableHeight;
    int x = padding.left;
    int y = padding.top;
    int i = 0;
    int maxFlex = 0;
    int totalFlex = 0;
    int maxWidth = 0;
    int totalHeight = 0;
    
    //Compute all information about the items
    for (i = 0; i < itemCount; i++){
        //Get the item config
        RedokesLayoutConfig * config = [itemConfigs objectAtIndex:i];
        
        //Ignore floating elements
        if(config.floating){
            continue;
        }
        
        //Compute the max flex
        if(config.flex >= maxFlex){
            maxFlex = config.flex;
        }
        
        //Compute the flexheight
        if(config.height == 0){
            totalFlex = totalFlex + config.flex;
        }
        else{
            flexHeight -= config.height;
            totalHeight += config.height;
        }
        
        //Compute the maxheight
        if(config.width > maxWidth){
            maxWidth = config.width;
        }
    }
    //NSLog(@" availableHeight=%d, flexWidth=%d, totalFlex=%d", availableHeight, flexHeight, totalFlex);
    
    //Determine if we need to pack the items
    if(totalFlex == 0 && totalHeight < availableHeight){
        if(self.pack == @"center"){
            y += (availableHeight - totalHeight) / 2;
        }
        if(self.pack == @"end"){
            y += (availableHeight - totalHeight);
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
        
        //Compute the item height
        int itemHeight = 0;
        if(config.height == 0){
            float flexRatio = (config.flex / (float)totalFlex);
            itemHeight += (int)round((flexHeight * flexRatio));
        }
        else{
            itemHeight += config.height;
        }
        itemHeight -= (config.margin.top + config.margin.bottom);
        
        //Compute the item width
        int itemWidth = config.width;
        if(self.align == @"stretch"){
            itemWidth = self.bounds.size.width - [[self getPadding] left] - [[self getPadding] right] - config.margin.left - config.margin.right;
        }
        if(self.align == @"stretchmax"){
            itemWidth = maxWidth;
        }
        if(self.align == @"middle"){
            itemY = y + ((maxWidth - itemWidth) / 2);
        }
        
        //Is this a floating element
        if(config.floating){
            itemX = item.frame.origin.x;
            itemY = item.frame.origin.y;
            itemWidth = self.bounds.size.width;
            itemHeight = self.bounds.size.height;
        }
        else{
            //Reset the x and y
            y = itemY + itemHeight + config.margin.bottom;
        }
        
        //Create the frame for the item
        CGRect frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        
        //Set the items frame
        [item setFrame:frame];
    }
    
    for (i = 0; i < itemCount; i++){
        //Get the item
        UIView *item = [items objectAtIndex:i];
        [item setNeedsDisplay];
    }
    
}

@end
