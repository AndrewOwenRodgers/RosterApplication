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
#import "CodeFellowCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *myStudentsArray;
@property (strong, nonatomic) NSArray *myTeachersArray;

@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self createArrays];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender //Sends the name of the CodeFellow object to the TextViewController
{
    CodeFellowCell *someCell = (CodeFellowCell *)sender;
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

- (void) viewDidAppear:(BOOL)animated //Saves data to the application's PList and also reloads the table's data
{
    [super viewDidAppear:animated];
    [self.myTableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.myStudentsArray toFile:[[TextViewController docsDirectoryPath] stringByAppendingString: @"Students archive"]];
    [NSKeyedArchiver archiveRootObject:self.myTeachersArray toFile:[[TextViewController docsDirectoryPath] stringByAppendingString: @"Teachers archive"]];
}


- (void) createArrays //Copies the data from the PList in the documents directory and creates the CodeFellow objects from them OR unarchives the files into the arrays
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (!([fileManager fileExistsAtPath:[[TextViewController docsDirectoryPath] stringByAppendingString:@"Students archive"]]))
    {
        NSString *filePlace = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
        NSArray *peopleArray = [[NSArray alloc] initWithContentsOfFile:filePlace]; //Contains an array with all the dictionaries of the PList's information
        NSMutableArray *tempStudentsArray = [[NSMutableArray alloc] initWithObjects: nil];
        NSMutableArray *tempTeachersArray = [[NSMutableArray alloc] initWithObjects: nil];
    
        for (NSDictionary *currentPerson in peopleArray) //This loop builds CodeFellow objects for each value in the array peopleArray, then sorts them into teacher and student arrays
        {
            CodeFellow *tempCF = [[CodeFellow alloc]initWithName:[currentPerson objectForKey:@"name"]
                                                      andTwitter:[currentPerson objectForKey:@"twitter"]
                                                       andGitHub:[currentPerson objectForKey:@"github"]
                                                  andTeacherhood:[[currentPerson objectForKey:@"isTeacher"] boolValue]
                                                         andPath:[currentPerson objectForKey:@"path"]];
        
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
    
    else
    {
        NSString *documentsDirectory = [TextViewController docsDirectoryPath];
        self.myStudentsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingString:@"Students archive"]];
        self.myTeachersArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingString:@"Teachers archive"]];
    }
}

#pragma -TableView / Cells

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView //Determines the number of sections in the UITableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section //Determines how many cells are needed in each of the teacher sections
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

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section //Labels the sections for teachers and students
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

- (CodeFellowCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath //Builds the cells
{
    CodeFellowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    if (indexPath.section == 0)
    {
        [cell setCF:[self.myStudentsArray objectAtIndex:indexPath.row]];
    }
    else if (indexPath.section == 1)
    {
        [cell setCF:[self.myTeachersArray objectAtIndex:indexPath.row]];
    }
    cell.tag = indexPath.row;
    return cell;
}


@end