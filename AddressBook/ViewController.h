//
//  ViewController.h
//  AddressBook
//
//  Created by duan on 13-9-26.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


typedef enum
{
    XD_ENUM_FILTER_TYPE_ALL = 0,
    XD_ENUM_FILTER_TYPE_SINA,
    XD_ENUM_FILTER_TYPE_FACEBOOK,
    XD_ENUM_FILTER_TYPE_PHOTO,
    XD_ENUM_FILTER_TYPE_MAIL
} XD_ENUM_FILTER_TYPE;

@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate>
{
    UITableView * listView;
    NSMutableArray * AllPerson;
    NSMutableArray * filterPerson;
    UIView * ClassPickerBGView;
    UIPickerView  *ClassPickerView;
    XD_ENUM_FILTER_TYPE filterType;
    int pickerSelectedRow;
    
    UILabel * countLabel;
}

@property(nonatomic,retain) NSMutableArray * AllPerson;
@property(nonatomic,retain) NSMutableArray * filterPerson;


@end
