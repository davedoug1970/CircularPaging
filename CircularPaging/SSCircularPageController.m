//
//  SSCircularPageController.m
//  CircularPaging
//
//  Created by David Douglas on 3/18/13.
//  Copyright (c) 2013 Software Smoothie. All rights reserved.
//

#import "SSCircularPageController.h"

@interface SSCircularPageController ()

@property (strong, nonatomic) UIView *currentView;
@property (strong, nonatomic) UIView *hiddenView;
@property (nonatomic) BOOL initialSetupComplete;

- (void)initialize;
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

@end

@implementation SSCircularPageController

@synthesize pageIndex=_pageIndex;
@synthesize currentView=_currentView;
@synthesize hiddenView=_hiddenView;
@synthesize pageControl=_pageControl;
@synthesize initialSetupComplete=_initialSetupComplete;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self setInitialSetupComplete:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup
{
    [self setPageIndex:0];
    [self setCurrentView:[[self dataSource] CircularPageView:self viewForPageIndex:[self pageIndex]]];
    
    if (![self initialSetupComplete])
    {
        [[self view] setBackgroundColor:[UIColor clearColor]];
        [[self mainView] addSubview:[self currentView]];
        
        /*
         Create a swipe gesture recognizer to recognize right swipes (the default).
         We're only interested in receiving messages from this recognizer, and the view will take ownership of it, so we don't need to keep a reference to it.
         */
        UIGestureRecognizer *recognizer;
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
        [(UISwipeGestureRecognizer *)recognizer setNumberOfTouchesRequired:1];
        [[self mainView] addGestureRecognizer:recognizer];
        
        /*
         Create a swipe gesture recognizer to recognize left swipes.
         Keep a reference to the recognizer so that it can be added to and removed from the view in takeLeftSwipeRecognitionEnabledFrom:.
         Add the recognizer to the view if the segmented control shows that left swipe recognition is allowed.
         */
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
        [(UISwipeGestureRecognizer *)recognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [(UISwipeGestureRecognizer *)recognizer setNumberOfTouchesRequired:1];
        [[self mainView] addGestureRecognizer:recognizer];
        
        [self setInitialSetupComplete:YES];
    }
    
    if ([self pageControl])
    {
        [[self pageControl] setNumberOfPages:[[self dataSource] count]];
    }
}

/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    [[self mainView] setUserInteractionEnabled:NO];
    
    int directionMultiplier = 0;
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self setPageIndex:[self pageIndex] - 1];
        directionMultiplier = -1;
        
        if ([self pageIndex] < 0)
            [self setPageIndex:[[self dataSource] count] - 1];
    }
    else
    {
        directionMultiplier = 1;
        [self setPageIndex:[self pageIndex] + 1];
    
        // if we have gone through all of the views then start over...
        if ([self pageIndex] == [[self dataSource] count])
            [self setPageIndex:0];
    }
    
    [self changePage:directionMultiplier];
}

- (IBAction)pageControlChanged:(id)sender
{
    int directionMultiplier = 0;
    
    if ([self pageIndex] < [[self pageControl] currentPage])
        directionMultiplier = 1;
    else
        directionMultiplier = -1;
    
    [self setPageIndex:[[self pageControl] currentPage]];
    [self changePage:directionMultiplier];
}

- (void)changePage:(int)directionMultiplier
{
    [self setHiddenView:[[self dataSource] CircularPageView:self viewForPageIndex:[self pageIndex]]];
    [[self hiddenView] setFrame:CGRectMake(320 * directionMultiplier, self.hiddenView.frame.origin.y, self.hiddenView.frame.size.width, self.hiddenView.frame.size.height)];
    [[self mainView] addSubview:[self hiddenView]];
    
    [UIView beginAnimations:@"transition" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [[self hiddenView] setFrame:CGRectMake(self.hiddenView.frame.origin.x - (320 * directionMultiplier), self.hiddenView.frame.origin.y, self.hiddenView.frame.size.width, self.hiddenView.frame.size.height)];
    [[self currentView] setFrame:CGRectMake(self.currentView.frame.origin.x - (320 * directionMultiplier), self.currentView.frame.origin.y, self.currentView.frame.size.width, self.currentView.frame.size.height)];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if (finished)
    {
        [[self currentView] removeFromSuperview];
        [self setCurrentView:[self hiddenView]];
        [[self mainView] setUserInteractionEnabled:YES];
        
        if ([self pageControl])
        {
            [[self pageControl] setCurrentPage:[self pageIndex]];
        }
    }
}

@end
