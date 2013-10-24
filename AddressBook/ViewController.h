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

@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView * tableView;
    NSMutableArray * AllPerson;
}

@property(nonatomic,retain) NSMutableArray * AllPerson;

@end
