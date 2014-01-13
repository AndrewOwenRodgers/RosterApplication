//
//  TextViewController.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/13/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UITextView *bioBox;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *releaseButton;

@end

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.bioBox.text = self.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
