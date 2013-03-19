//
//  SSFlipsideViewController.h
//  CircularPaging
//
//  Created by David Douglas on 3/18/13.
//  Copyright (c) 2013 Software Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSFlipsideViewController;

@protocol SSFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(SSFlipsideViewController *)controller;
@end

@interface SSFlipsideViewController : UIViewController

@property (weak, nonatomic) id <SSFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
