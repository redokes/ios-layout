//
//  BseLayout.m
//  TestApp
//
//  Created by Jared Lewis on 6/26/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import "RedokesLayoutBase.h"
#import "RedokesLayoutBox.h"
#import "RedokesLayoutConfig.h"

@implementation RedokesLayoutBase

/////////////////////////////////////////////////////////////////////////////////////////////////
//  Properties
/////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize align;
@synthesize pack;


/////////////////////////////////////////////////////////////////////////////////////////////////
//  Constructors
/////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        items = [[NSMutableArray alloc] init];
        itemConfigs = [[NSMutableArray alloc] init];
        originalFrame = frame;
        [self setPadding:0];
        [self setMargin:0];
        [self setAlign:@"stretch"];
    }
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
//  Getters
/////////////////////////////////////////////////////////////////////////////////////////////////
- (RedokesLayoutBox *)getPadding{
    return padding;
}

- (RedokesLayoutBox *)getMargin{
    return margin;
}

- (NSString *)getMethodName:(NSString *)property
{
    NSString * methodName = @"set";
    property = [property stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[property substringToIndex:1] uppercaseString]];
    return [[methodName stringByAppendingString:property] stringByAppendingString:@":"];
}

/////////////////////////////////////////////////////////////////////////////////////////////////
//  Setters
/////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setPadding:(RedokesLayoutBox *)paddingBox
{
    //Set the padding
    padding = paddingBox;
    
    //Add observer to padding
    [padding addObserver:self forKeyPath:@"top" options:(NSKeyValueChangeSetting) context:NULL];
    [padding addObserver:self forKeyPath:@"right" options:(NSKeyValueChangeSetting) context:NULL];
    [padding addObserver:self forKeyPath:@"bottom" options:(NSKeyValueChangeSetting) context:NULL];
    [padding addObserver:self forKeyPath:@"left" options:(NSKeyValueChangeSetting) context:NULL];
    
    //Mark as needing to be displayed
    [self setNeedsDisplay];
}

- (void)setMargin:(RedokesLayoutBox *)marginBox
{
    //Set the margin
    margin = marginBox;
    
    //Add observer to margin
    [margin addObserver:self forKeyPath:@"top" options:(NSKeyValueChangeSetting) context:NULL];
    [margin addObserver:self forKeyPath:@"right" options:(NSKeyValueChangeSetting) context:NULL];
    [margin addObserver:self forKeyPath:@"bottom" options:(NSKeyValueChangeSetting) context:NULL];
    [margin addObserver:self forKeyPath:@"left" options:(NSKeyValueChangeSetting) context:NULL];
    
    //Mark as needing to be displayed
    [self setNeedsDisplay];
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////
//  Methods
/////////////////////////////////////////////////////////////////////////////////////////////////

/**
 Add An item with a default config
 **/
- (id)add:(id)item
{
    //Create a default config
    RedokesLayoutConfig * config = [[RedokesLayoutConfig alloc] init];
    
    //Call the add with config method
    return [self add:item config:config];
}

/**
 Add An item with a config
 **/
- (id)add:(id)item config:(RedokesLayoutConfig *)config
{
    //Add item to items array / config array
    [items addObject:item];
    [itemConfigs addObject:config];
    
    //Add item to the subview
    [self addSubview:item];
    
    //Mark as needing to be displayed
    [self setNeedsDisplay];
    
    //Return the item back to the user
    return item;
}

- (void)setConfig:(NSMutableDictionary *)config
{
    for(id key in config){
        NSLog(@"%@ %@ %@", key, [config objectForKey:key], [self getMethodName:key]);
        SEL selector = NSSelectorFromString([self getMethodName:key]);
        if ([self respondsToSelector:selector] == YES) {
            [self performSelector:selector withObject:[config objectForKey:key]];
        }
    }
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    NSLog(@"Draw rect");
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
//  Observors
/////////////////////////////////////////////////////////////////////////////////////////////////

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self setNeedsDisplay];
}

@end
