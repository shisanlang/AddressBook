//
//  AddressLineCell.h
//  AddressBook
//
//  Created by duan on 13-10-30.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressLineCell : UITableViewCell
{
    UILabel * userName;
    UILabel * userSubtext;
    UIImageView * userPhoto;
}

@property(nonatomic,retain) UILabel * userName;
@property(nonatomic,retain) UILabel * userSubtext;
@property(nonatomic,retain) UIImageView * userPhoto;

@end
