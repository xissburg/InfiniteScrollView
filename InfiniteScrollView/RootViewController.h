//
//  RootViewController.h
//  InfiniteScrollView
//
//  Created by xissburg on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfiniteScrollView;

@interface RootViewController : UIViewController {
    InfiniteScrollView *_infiniteScrollView;
}

@property (nonatomic, retain) InfiniteScrollView *infiniteScrollView;

@end
