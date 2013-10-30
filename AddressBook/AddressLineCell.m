//
//  AddressLineCell.m
//  AddressBook
//
//  Created by duan on 13-10-30.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import "AddressLineCell.h"

@implementation AddressLineCell

@synthesize userName;
@synthesize userSubtext;
@synthesize userPhoto;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        userName=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        userName.backgroundColor=[UIColor clearColor];
        userName.font=[UIFont boldSystemFontOfSize:15];
        userName.textColor=[UIColor blackColor];
        userName.text=@"名字";
        userName.textAlignment=UITextAlignmentLeft;
        [self addSubview:userName];
        
        userSubtext=[[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
        userSubtext.backgroundColor=[UIColor clearColor];
        userSubtext.font=[UIFont boldSystemFontOfSize:15];
        userSubtext.textColor=[UIColor blackColor];
        userSubtext.text=@"135xxxxxxxx";
        userSubtext.textAlignment=UITextAlignmentLeft;
        [self addSubview:userSubtext];
        
        userPhoto = [[UIImageView alloc]init];
        userPhoto.frame = CGRectMake(250, 10, 50, 50);
        [self addSubview:userPhoto];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
