//
//  TextViewController.h
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/13/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeFellow.h"

@interface TextViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) CodeFellow *CF;

@end
