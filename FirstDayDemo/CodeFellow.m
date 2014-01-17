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

@end

@implementation CodeFellow

-(id) initWithName:(NSString *)myName andTwitter:(NSString *)myTwitter andGitHub:(NSString *) myGit andTeacherhood:(BOOL)teacherhood andPath:(NSString *)path
{
    self = [super init];
    self.name = myName;
    self.twitterAccount = myTwitter;
    self.gitHubAccount = myGit;
    self.isTeacher = teacherhood;
    self.picturePath = path;
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.name = [decoder decodeObjectForKey:@"name"];
    self.gitHubAccount = [decoder decodeObjectForKey:@"github"];
    self.picturePath = [decoder decodeObjectForKey:@"path"];
    self.twitterAccount = [decoder decodeObjectForKey:@"twitter"];
    self.isTeacher = [decoder decodeBoolForKey:@"isTeacher"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.twitterAccount forKey:@"twitter"];
    [encoder encodeObject:self.gitHubAccount forKey:@"github"];
    [encoder encodeObject:self.picturePath forKey:@"path"];
    [encoder encodeBool:self.isTeacher forKey:@"isTeacher"];
}

@end
