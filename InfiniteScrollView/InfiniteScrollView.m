//
//  InfiniteScrollView.m
//  InfiniteScrollView
//
//  Created by xissburg on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfiniteScrollView.h"


@interface InfiniteScrollView ()

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *scrollSubviews;
@property (nonatomic, retain) NSArray *contentViews;

@end


@implementation InfiniteScrollView

@synthesize scrollView=_scrollView;
@synthesize scrollSubviews=_scrollSubviews;
@synthesize contentViews=_contentViews;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollSubviews = [NSMutableArray array];
        
        self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        [super addSubview:self.scrollView];//NOTICE THE super. addSubview: is overriden in this class.
        self.scrollView.delegate = self;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.contentViews = [NSArray arrayWithObjects:[[[UIView alloc] initWithFrame:CGRectZero] autorelease], [[[UIView alloc] initWithFrame:CGRectZero] autorelease], [[[UIView alloc] initWithFrame:CGRectZero] autorelease], [[[UIView alloc] initWithFrame:CGRectZero] autorelease], nil];
        
        for (UIView *contentView in self.contentViews) {
            [self.scrollView addSubview:contentView];
        }
        
        
        
        
        CGSize contentSize = CGSizeMake(100000, 0);
        CGFloat x = contentSize.width/2;
        
        for (UIView *view in self.scrollSubviews) {
            [self.scrollView addSubview:view];
            CGRect f = view.frame;
            f.origin.x = x;
            f.origin.y = 0;
            view.frame = f;
            x += f.size.width;
            
            if (f.size.height > contentSize.height) {
                contentSize.height = f.size.height;
            }
        }
        
        CGFloat size = 1<<24;
        self.scrollView.contentSize = CGSizeMake(size, size);
        self.scrollView.contentOffset = CGPointMake(size/2, size/2);
    }
    return self;
}


- (void)dealloc
{
    self.scrollSubviews = nil;
    self.scrollView = nil;
    self.contentViews = nil;
    [super dealloc];
}


#pragma mark - Properties

- (CGSize)contentSize
{
    return [[self.contentViews objectAtIndex:0] frame].size;
}

- (void)setContentSize:(CGSize)contentSize
{
    for (UIView *contentView in self.contentViews) {
        CGRect r = contentView.frame;
        r.size = contentSize;
        contentView.frame = r;
    }
}

#pragma mark - Overrides

- (void)addSubview:(UIView *)view
{
    [[self.contentViews objectAtIndex:0] addSubview:view];
}


#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

/*
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
}*/


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
}

/*
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    
}*/


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}

@end
