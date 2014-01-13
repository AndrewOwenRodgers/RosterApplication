//
//  ViewController.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/13/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *myStudentsArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *student1 = [NSString stringWithFormat:@"Brad"];
    NSString *student2 = [NSString stringWithFormat:@"Clem"];
    NSString *student3 = [NSString stringWithFormat:@"Billy Bob"];
    NSString *student4 = @"John";
    
    self.myStudentsArray = [NSArray arrayWithObjects:student1, student2, student3, student4, nil];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myStudentsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];
    cell.textLabel.text = [self.myStudentsArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
