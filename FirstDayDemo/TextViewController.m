//
//  TextViewController.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/13/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//
//  Methods "textFieldDidBeginEditing" and "textFieldDidBeginEditing" adapted from Matt Gallagher, http://www.cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html

#import "TextViewController.h"

@interface TextViewController ()

{
    CGFloat animatedDistance;
}

@property (weak, nonatomic) IBOutlet UITextField *twitterLabel;
@property (weak, nonatomic) IBOutlet UITextField *gitHubLabel;

@end

@implementation TextViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162; //All of these constants are for use sliding the keyboard up

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.CF.name;
    self.twitterLabel.delegate = self;
    self.gitHubLabel.delegate = self;
    
    if (!(self.CF.twitterAccount == nil))
    {
        self.twitterLabel.text = self.CF.twitterAccount;
    }
    else
    {
        self.twitterLabel.text = @"Twitter handle";
        self.twitterLabel.textColor = [UIColor darkGrayColor];
    }
    
    if (!(self.CF.gitHubAccount == nil))
    {
        self.gitHubLabel.text = self.CF.gitHubAccount;
    }
    else
    {
        self.gitHubLabel.text = @"GitHub handle";
        self.gitHubLabel.textColor = [UIColor darkGrayColor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField //Gets rid of the keyboard
{
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField //Slides the view up when the keyboard appears
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField //Slides the view back down when the text field is finished being edited, and also sets the Twitter and GitHub labels
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
    if (textField.tag == 0)
    {
        self.CF.twitterAccount = textField.text;
    }
    else
    {
        self.CF.gitHubAccount = textField.text;
    }
}

@end
