//
//  SSCircularPageController.h
//  CircularPaging
//
//  Created by David Douglas on 3/18/13.
//  Copyright (c) 2013 Software Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSCircularPageController;

@protocol SSCircularPageDataSource <NSObject>

- (UIView *) CircularPageView:(SSCircularPageController *)controller viewForPageIndex:(int)index;
- (int) count;

@end

@interface SSCircularPageController : UIViewController

@property (strong, nonatomic) IBOutlet id<SSCircularPageDataSource> dataSource;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (assign, nonatomic) int pageIndex;

- (void)setup;
- (IBAction)pageControlChanged:(id)sender;

@end
