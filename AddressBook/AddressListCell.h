//
//  AddressListCell.h
//  AddressBook
//
//  Created by duan on 13-10-30.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListCell : UITableViewCell
{
    UILabel * userName;
    UILabel * userPhone;
    UILabel * userSina;
    UILabel * userFacebook;
    UILabel * userMail;
    UIImageView * userPhoto;
    UILabel * userCreateDate;
    UILabel * userUpdateDate;
}

@property(nonatomic,retain) UILabel * userName;
@property(nonatomic,retain) UILabel * userPhone;
@property(nonatomic,retain) UILabel * userSina;
@property(nonatomic,retain) UILabel * userFacebook;
@property(nonatomic,retain) UILabel * userMail;
@property(nonatomic,retain) UIImageView * userPhoto;
@property(nonatomic,retain) UILabel * userCreateDate;
@property(nonatomic,retain) UILabel * userUpdateDate;

@end
