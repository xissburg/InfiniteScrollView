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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        
        NSMutableArray *subviews = [NSMutableArray array];
        NSString *imagePath = nil;
        NSUInteger i = 0;
        
        while ((imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"image_%d", i++] ofType:@"jpg"])) {
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            image = ResizeImagePreserve(image, 256, 256);
            UIImageView *imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
            imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            [subviews addObject:imageView];
        }
        
        infiniteScrollView = [[InfiniteScrollView alloc] initWithFrame:frame subviews:subviews];
        //infiniteScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:infiniteScrollView];
    }
    return self;
}

- (void)dealloc
{
    [infiniteScrollView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.view = view;
    [view release];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
