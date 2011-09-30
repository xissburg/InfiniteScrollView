//
//  InfiniteScrollView.h
//  InfiniteScrollView
//
//  Created by xissburg on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfiniteScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    NSArray *_contentViews;
}

@property (nonatomic, assign) CGSize contentSize;

@end
