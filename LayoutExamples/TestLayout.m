//
//  TestLayout.m
//  TestApp
//
//  Created by Jared Lewis on 6/27/12.
//  Copyright (c) 2012 JaredLewis. All rights reserved.
//

#import "TestLayout.h"
#import "RedokesLayout.h"

@implementation TestLayout

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //Init the config
        [self setAlign:@"stretch"];
        [self setPack:@"center"];
        
        //Init the items
        [self initHeader];
        [self initCenter];
        [self initFooter];
        
    }
    return self;
}

///////////////////////////////////////////////////////////////////////
//  Init Methods
///////////////////////////////////////////////////////////////////////

-(void) initHeader
{
    header = [[RedokesLayoutHorizontal alloc] init];
    [header setBackgroundColor:[UIColor cyanColor]];
    RedokesLayoutConfig * headerConfig = [[RedokesLayoutConfig alloc] init];
    [self add:header config:headerConfig];
    
    //Create a toolbar
    UIToolbar * toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleDefault];
    [header add:toolbar];
    
    UIBarButtonItem * noogaButton = [[UIBarButtonItem alloc] initWithTitle:@"Nooga.com"
                                                                    style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(loadNooga:)
    ];
    UIBarButtonItem * googleButton = [[UIBarButtonItem alloc] initWithTitle:@"Google.com"
                                                                    style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(loadGoogle:)
    ];
    [toolbar setItems:[[NSArray alloc] initWithObjects:noogaButton, googleButton, nil]];
}
-(void) initCenter
{
    //Create a webview in the center
    center = [[UIWebView alloc] init];
    RedokesLayoutConfig * webviewConfig = [[RedokesLayoutConfig alloc] init];
    [self add:center config:webviewConfig];
}
-(void) initFooter
{
    //Add a footer
    footer = [[RedokesLayoutHorizontal alloc] init];
    [footer setBackgroundColor:[UIColor yellowColor]];
    [footer setAlign:@"stretch"];
    [footer setPack:@"center"];
    RedokesLayoutConfig * footerConfig = [[RedokesLayoutConfig alloc] init];
    [self add:footer config:footerConfig];
}

///////////////////////////////////////////////////////////////////////
//  Observors
///////////////////////////////////////////////////////////////////////

- (void)loadNooga:(id)sender{
    NSString * urlString = [NSString stringWithFormat:@"http://nooga.com/mobile"];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * requestObj = [NSURLRequest requestWithURL:url];
    [center loadRequest:requestObj];
}

- (void)loadGoogle:(id)sender{
    NSString * urlString = [NSString stringWithFormat:@"http://google.com"];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * requestObj = [NSURLRequest requestWithURL:url];
    [center loadRequest:requestObj];
}

@end
