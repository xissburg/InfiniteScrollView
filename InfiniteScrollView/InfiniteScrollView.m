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
@property (nonatomic, assign) CGSize actualContentSize;

@end


@implementation InfiniteScrollView

@synthesize scrollView=_scrollView;
@synthesize scrollSubviews=_scrollSubviews;
@synthesize actualContentSize;


- (id)initWithFrame:(CGRect)frame subviews:(NSArray *)subviews
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollSubviews = [NSMutableArray arrayWithArray:subviews];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView = scrollView;
        [scrollView release];
        
        [self addSubview:self.scrollView];
        self.scrollView.delegate = self;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
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
        
        actualContentSize = CGSizeMake(x, contentSize.height);
        
        self.scrollView.contentSize = contentSize;
        
        CGPoint o = self.scrollView.contentOffset;
        o.x = contentSize.width/2;
        self.scrollView.contentOffset = o;
    }
    return self;
}


- (void)dealloc
{
    self.scrollSubviews = nil;
    self.scrollView = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *leftmostView = [self.scrollSubviews objectAtIndex:0];
    UIView *rightmostView = [self.scrollSubviews lastObject];
    
    if (self.scrollView.contentOffset.x < leftmostView.frame.origin.x) {
        NSLog(@"contentOffset.x=%.1f", self.scrollView.contentOffset.x);
        NSLog(@"leftmostView.frame.origin.x=%.1f", leftmostView.frame.origin.x);
        CGRect f = rightmostView.frame;
        f.origin.x = leftmostView.frame.origin.x - rightmostView.frame.size.width;
        rightmostView.frame = f;
        [self.scrollSubviews removeLastObject];
        [self.scrollSubviews insertObject:rightmostView atIndex:0];
    }
    else if(self.scrollView.contentOffset.x + self.scrollView.frame.size.width > rightmostView.frame.origin.x + rightmostView.frame.size.width) {
        CGRect f = leftmostView.frame;
        f.origin.x = rightmostView.frame.origin.x + rightmostView.frame.size.width;
        leftmostView.frame = f;
        [self.scrollSubviews removeObjectAtIndex:0];
        [self.scrollSubviews addObject:leftmostView];
    }
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
