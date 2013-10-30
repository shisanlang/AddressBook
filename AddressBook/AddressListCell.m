//
//  AddressListCell.m
//  AddressBook
//
//  Created by duan on 13-10-30.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import "AddressListCell.h"

@implementation AddressListCell

@synthesize userName;
@synthesize userPhone;
@synthesize userSina;
@synthesize userFacebook;
@synthesize userMail;
@synthesize userPhoto;
@synthesize userCreateDate;
@synthesize userUpdateDate;

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
        
        userPhone=[[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
        userPhone.backgroundColor=[UIColor clearColor];
        userPhone.font=[UIFont boldSystemFontOfSize:15];
        userPhone.textColor=[UIColor blackColor];
        userPhone.text=@"135xxxxxxxx";
        userPhone.textAlignment=UITextAlignmentLeft;
        [self addSubview:userPhone];
        
        userSina=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 20)];
        userSina.backgroundColor=[UIColor clearColor];
        userSina.font=[UIFont boldSystemFontOfSize:15];
        userSina.textColor=[UIColor blackColor];
        userSina.text=@"新浪名字";
        userSina.textAlignment=UITextAlignmentLeft;
        [self addSubview:userSina];
        
        userFacebook=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 200, 20)];
        userFacebook.backgroundColor=[UIColor clearColor];
        userFacebook.font=[UIFont boldSystemFontOfSize:15];
        userFacebook.textColor=[UIColor blackColor];
        userFacebook.text=@"Facebook名字";
        userFacebook.textAlignment=UITextAlignmentLeft;
        [self addSubview:userFacebook];
        
        userMail=[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 200, 20)];
        userMail.backgroundColor=[UIColor clearColor];
        userMail.font=[UIFont boldSystemFontOfSize:15];
        userMail.textColor=[UIColor blackColor];
        userMail.text=@"邮件@163.com";
        userMail.textAlignment=UITextAlignmentLeft;
        [self addSubview:userMail];
        
        userCreateDate=[[UILabel alloc] initWithFrame:CGRectMake(20, 110, 200, 20)];
        userCreateDate.backgroundColor=[UIColor clearColor];
        userCreateDate.font=[UIFont boldSystemFontOfSize:15];
        userCreateDate.textColor=[UIColor blackColor];
        userCreateDate.text=@"2013-10-30 10:27:00";
        userCreateDate.textAlignment=UITextAlignmentLeft;
        [self addSubview:userCreateDate];
        
        userUpdateDate=[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 200, 20)];
        userUpdateDate.backgroundColor=[UIColor clearColor];
        userUpdateDate.font=[UIFont boldSystemFontOfSize:15];
        userUpdateDate.textColor=[UIColor blackColor];
        userUpdateDate.text=@"2013-10-30 10:27:00";
        userUpdateDate.textAlignment=UITextAlignmentLeft;
        [self addSubview:userUpdateDate];
        
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
