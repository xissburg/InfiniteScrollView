//
//  RootViewController.m
//  InfiniteScrollView
//
//  Created by xissburg on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "InfiniteScrollView.h"


UIImage* ResizeImage(UIImage *image, NSUInteger width, NSUInteger height, BOOL preserveAspect);
UIImage* ResizeImagePreserve(UIImage *image, NSUInteger width, NSUInteger height);


@implementation RootViewController

@synthesize infiniteScrollView=_infiniteScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    self.infiniteScrollView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.infiniteScrollView = [[[InfiniteScrollView alloc] initWithFrame:self.view.frame] autorelease];
    
    NSString *imagePath = nil;
    NSUInteger i = 0;
    CGSize contentSize = CGSizeZero;
    
    while ((imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"image_%d", i++] ofType:@"jpg"])) {
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        image = ResizeImagePreserve(image, 256, 256);
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
        imageView.frame = CGRectMake(contentSize.width, 0, image.size.width, image.size.height);
        [self.infiniteScrollView addSubview:imageView];
        
        contentSize.width += imageView.frame.size.width;
        
        if (imageView.frame.size.height > contentSize.height) {
            contentSize.height = imageView.frame.size.height;
        }
    }
    
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:CGRectMake(contentSize.width, 0, 384, 256)] autorelease];
    webView.scalesPageToFit = YES;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://xissburg.com"]]];
    [self.infiniteScrollView addSubview:webView];
    
    contentSize.width += webView.frame.size.width;
    
    if (webView.frame.size.height > contentSize.height) {
        contentSize.height = webView.frame.size.height;
    }
    
    self.infiniteScrollView.contentSize = contentSize;
    
    //infiniteScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.infiniteScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.infiniteScrollView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


UIImage* ResizeImage(UIImage *image, NSUInteger width, NSUInteger height, BOOL preserveAspect) {
    if (preserveAspect) {
        if (image.size.width > image.size.height) {
            height *= image.size.height/image.size.width;
        }
        else {
            width *= image.size.width/image.size.height;
        }
    }
    
	UIGraphicsBeginImageContext(CGSizeMake(width, height));
	CGRect imageRect = CGRectMake(0.0, 0.0, width, height);
	[image drawInRect:imageRect];
	UIImage *imageRet = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageRet;
}


UIImage* ResizeImagePreserve(UIImage *image, NSUInteger width, NSUInteger height) {
	return ResizeImage(image, width, height, YES);
}

@end
