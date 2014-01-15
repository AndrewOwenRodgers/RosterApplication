//
//  TextViewController.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/13/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UIImageView *personPicture;

@end

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.CF.name;
    self.twitterLabel.text = self.CF.twitterAccount;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
