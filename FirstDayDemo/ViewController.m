//
//  ViewController.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/13/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import "ViewController.h"
#import "TextViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITableView *myTeachersTableView;
@property (strong, nonatomic) NSArray *myStudentsArray;
@property (strong, nonatomic) NSArray *myTeachersArray;
@property (strong, nonatomic) NSDictionary *myBios;
@property (weak, nonatomic) IBOutlet UIButton *callTextView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *student1 = [NSString stringWithFormat:@"Nicholas Barnard"];
    NSString *student2 = [NSString stringWithFormat:@"Zuri Biringer"];
    NSString *student3 = [NSString stringWithFormat:@"Chad Colby"];
    NSString *student4 = [NSString stringWithFormat:@"Spencer Fornaciari"];
    NSString *student5 = [NSString stringWithFormat:@"Raghav Haran"];
    NSString *student6 = [NSString stringWithFormat:@"Timothy Hise"];
    NSString *student7 = [NSString stringWithFormat:@"Ivan Lesko"];
    NSString *student8 = [NSString stringWithFormat:@"Richard Lichkus"];
    NSString *student9 = [NSString stringWithFormat:@"Bennett Lin"];
    NSString *student10 = [NSString stringWithFormat:@"Christopher Meehan"];
    NSString *student11 = [NSString stringWithFormat:@"Matt Remick"];
    NSString *student12 = [NSString stringWithFormat:@"Andrew Rodgers"];
    NSString *student13 = [NSString stringWithFormat:@"Jeff Schwab"];
    NSString *student14 = [NSString stringWithFormat:@"Steven Stevenson"];
    NSString *student15 = [NSString stringWithFormat:@"Yair Szarf"];
    
    NSString *teacher1 = [NSString stringWithFormat:@"John Clem"];
    NSString *teacher2 = [NSString stringWithFormat:@"Brad Johnson"];
    NSString *teacher3 = [NSString stringWithFormat:@"Ivan Storck"];
    
    
    self.myStudentsArray = [NSArray arrayWithObjects:student1, student2, student3, student4, student5, student6, student7, student8, student9, student10, student11, student12, student13, student14, student15, nil];
    self.myTeachersArray = [NSArray arrayWithObjects:teacher1, teacher2, teacher3, nil];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.myStudentsArray.count;
    }
    else if (section == 1)
    {
        return self.myTeachersArray.count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
    {
        return @"Students";
    }
    if(section == 1)
    {
        return @"Teachers";
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [self.myStudentsArray objectAtIndex:indexPath.row];
    }
    
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = [self.myTeachersArray objectAtIndex:indexPath.row];
    }
    cell.tag = indexPath.row;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *someCell = (UITableViewCell *)sender;
    if ([segue.identifier isEqualToString: @"detailSegue"])
    {
        TextViewController *destinationVC = segue.destinationViewController;
        destinationVC.name = someCell.textLabel.text;
    }
}

@end
