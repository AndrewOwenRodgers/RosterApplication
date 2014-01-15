//
//  ViewController.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/13/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import "ViewController.h"
#import "TextViewController.h"
#import "CodeFellow.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *myStudentsArray;
@property (strong, nonatomic) NSArray *myTeachersArray;
@property (weak, nonatomic) IBOutlet UIButton *callTextView;

@end

@implementation ViewController

- (void)viewDidLoad
{
//    [self copyPlist];
    [self createArrays];
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void)createArrays //Copies the data from the PList in the documents directory and creates the CodeFellow objects from them
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
//    NSString *filePlace = [documentsDirectory stringByAppendingString:@"Bootcamp.plist"];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
    NSArray *peopleArray = [[NSArray alloc] initWithContentsOfFile:bundlePath]; //Contains an array with all the dictionaries of the PList's information NOTE TO SELF: ANDREW, CHANGE THIS PATH BACK TOMORROW
    NSMutableArray *tempStudentsArray = [[NSMutableArray alloc] initWithObjects: nil];
    NSMutableArray *tempTeachersArray = [[NSMutableArray alloc] initWithObjects: nil];
    
    for (NSDictionary *currentPerson in peopleArray) //This loop builds CodeFellow objects for each value in the array peopleArray, then sorts them into teacher and student arrays
    {
        CodeFellow *tempCF = [[CodeFellow alloc]initWithName:[currentPerson objectForKey:@"name"] andTwitter:[currentPerson objectForKey:@"twitter"] andGitHub:[currentPerson objectForKey:@"github"] andTeacherhood:[[currentPerson objectForKey:@"isTeacher"] boolValue]];
        if ([[currentPerson objectForKey:@"isTeacher"] boolValue])
        {
            [tempTeachersArray addObject:tempCF];
        }
        else
        {
            [tempStudentsArray addObject:tempCF];
        }
    }
    
    NSSortDescriptor *alphabeticalSorter = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = @[alphabeticalSorter];
    
    self.myStudentsArray = [tempStudentsArray sortedArrayUsingDescriptors:sortDescriptors];
    self.myTeachersArray = [tempTeachersArray sortedArrayUsingDescriptors:sortDescriptors];
}

//- (void)copyPlist //Copies the PList from the main bundle into the documents directory
//{
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
//    if (![fm fileExistsAtPath:[documentsDirectory stringByAppendingString: @"Bootcamp.plist"]])
//    {
//        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
//        [fm copyItemAtPath:bundlePath toPath:documentsDirectory error:nil];
//    }
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView //Determines the number of sections in the UITableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section //Determines how many cells are needed in each of the teacher sections
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section //Labels the sections for teachers and students
{
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath //Sets the cell texts as the name of a student or teacher
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [[self.myStudentsArray objectAtIndex:indexPath.row] name];
    }
    
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = [[self.myTeachersArray objectAtIndex:indexPath.row] name];
    }
    cell.tag = indexPath.row;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender //Sends the name of the CodeFellow object to the TextViewController
{
    UITableViewCell *someCell = (UITableViewCell *)sender;
    NSIndexPath *path = [self.myTableView indexPathForCell:someCell];
    if ([segue.identifier isEqualToString: @"detailSegue"])
    {
        TextViewController *destinationVC = segue.destinationViewController;
        destinationVC.name = someCell.textLabel.text;
        if (path.section == 0)
        {
            destinationVC.CF = [self.myStudentsArray objectAtIndex:someCell.tag];
        }
        else
        {
            destinationVC.CF = [self.myTeachersArray objectAtIndex:someCell.tag];
        }
    }
}

@end
