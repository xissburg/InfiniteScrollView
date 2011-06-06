//
//  main.m
//  InfiniteScrollView
//
//  Created by xissburg on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *delegateClassName = UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad? @"InfiniteScrollViewAppDelegate_iPad":  @"InfiniteScrollViewAppDelegate_iPhone";
    int retVal = UIApplicationMain(argc, argv, nil, delegateClassName);
    [pool release];
    return retVal;
}
