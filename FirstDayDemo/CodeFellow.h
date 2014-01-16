//
//  CodeFellow.h
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/14/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeFellow : NSObject

@property (nonatomic) NSString *twitterAccount;
@property (nonatomic) NSString *picturePath;
@property (nonatomic) NSString *gitHubAccount;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) BOOL isTeacher;

-(id) initWithName:(NSString *)myName andTwitter:(NSString *)myTwitter andGitHub:(NSString *) myGit andTeacherhood:(BOOL)teacherhood;

@end
