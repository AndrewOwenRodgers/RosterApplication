//
//  CodeFellowCell.m
//  FirstDayDemo
//
//  Created by Andrew Rodgers on 1/16/14.
//  Copyright (c) 2014 Andrew Rodgers. All rights reserved.
//

#import "CodeFellowCell.h"

@interface CodeFellowCell()

@end

@implementation CodeFellowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCF:(CodeFellow *)CF
{
    _CF = CF;
    if ([[NSFileManager defaultManager] fileExistsAtPath:_CF.picturePath])
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imgView.image = [UIImage imageWithContentsOfFile:_CF.picturePath];
        self.imageView.layer.cornerRadius = 8;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.image = imgView.image;
    }
    else
    {
        self.imageView.image = NULL;
    }
    self.textLabel.text = _CF.name;
}

@end
