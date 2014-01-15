//
//  CodeFellow.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/14/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import "CodeFellow.h"

@interface CodeFellow() //This class is designed to hold contact information for a person in CodeFellow's iOS bootcamp.

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) BOOL isTeacher;
@property (nonatomic, readwrite) UIImage *picture;

@end

@implementation CodeFellow

-(id) initWithName:(NSString *)myName andTwitter:(NSString *)myTwitter andGitHub:(NSString *) myGit andTeacherhood:(BOOL)teacherhood
{
    self = [super init];
    self.name = myName;
    self.twitterAccount = myTwitter;
    self.gitHubAccount = myGit;
    self.isTeacher = teacherhood;
    return self;
}

@end
