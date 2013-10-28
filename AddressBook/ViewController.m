//
//  ViewController.m
//  AddressBook
//
//  Created by duan on 13-9-26.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import "ViewController.h"
#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>

//#import <CoreTelephony/CoreTelephonyDefines.h>
//#import <CoreTelephony/CTCall.h>
//#import <CoreTelephony/CTCallCenter.h>
//#import <CoreTelephony/CTSubscriber.h>
//#import <CoreTelephony/CTSubscriberInfo.h>




@interface ViewController ()

@end

@implementation ViewController

@synthesize AllPerson;
@synthesize filterPerson;

//extern NSString* CTSettingCopyMyPhoneNumber();


//+(NSString *) phoneNumber {
//    NSString *phone = CTSettingCopyMyPhoneNumber();
//    
//    return phone;
//}
#pragma mark Load

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"我的通讯录";

    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
         [self.view.window setBackgroundColor:[UIColor whiteColor]];
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if (XD_IOS7) {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    //
    countLabel = [[UILabel alloc]init];
    countLabel.frame = CGRectMake(10, 20, 50, 24);
    countLabel.text = @"0条";
    [self.view addSubview:countLabel];
    
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(filterPhone:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"过滤" forState:UIControlStateNormal];
    button.frame = CGRectMake(240.0, 20, 60.0, 24.0);
    [self.view addSubview:button];
    
    //
    listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain];
	listView.dataSource = self;
	listView.delegate = self;
    [self.view addSubview:listView];
    
    AllPerson = [[NSMutableArray alloc] init];
    filterPerson = [[NSMutableArray alloc] init];
    
    [self initAddress];
    filterType = XD_ENUM_FILTER_TYPE_ALL;
    [self filterPersonTouchUp];
    [self initPicker];

}

#pragma mark Events

- (void) filterPhone:(id)sender
{
    [self showPicker];
}

- (void) showPicker
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    ClassPickerBGView.frame=CGRectMake(0, XD_SCREENHEIGHT-216-42, 320, 216+42);
    [UIView commitAnimations];
}

//
#pragma mark init

- (void) initPicker
{
    
    //PikerView
    ClassPickerBGView=[[UIView alloc] initWithFrame:CGRectMake(0, 600, 320, 216+42)];
    ClassPickerBGView.backgroundColor = RGBA(133, 133, 133, .5);
    [self.view addSubview:ClassPickerBGView];
    
    UIImageView *DPButtonBGView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
    DPButtonBGView.image=[UIImage imageNamed:@"transparent_bg.png"];
    [ClassPickerBGView addSubview:DPButtonBGView];
//    [DPButtonBGView release];
    
    UIButton *DPCancelButton = [UIButton buttonWithType:100];
    DPCancelButton.frame = CGRectMake(5, 5, 60, 30);
    [DPCancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [DPCancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [DPCancelButton addTarget:self action:@selector(DPCancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [ClassPickerBGView addSubview:DPCancelButton];
    
    UIButton *DPOKButton = [UIButton buttonWithType:100];
    DPOKButton.frame = CGRectMake(265, 5, 60, 30);
    [DPOKButton setTitle:@"确定" forState:UIControlStateNormal];
    [DPOKButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [DPOKButton addTarget:self action:@selector(DPOKButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [ClassPickerBGView addSubview:DPOKButton];
    
    
    
    ClassPickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 42, 320, 216)];
	ClassPickerView.showsSelectionIndicator = YES;
	ClassPickerView.delegate=self;
    [ClassPickerBGView addSubview:ClassPickerView];
    
}

- (void) initAddress
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        
        //iOS 6 later
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //        dispatch_release(sema);
    }
    else { //iOS 5 or older
        
        accessGranted = YES;
    }
    
    if (accessGranted) {
        
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        for(int i = 0; i < CFArrayGetCount(results); i++)
        {
            NSMutableDictionary * personDic = [[NSMutableDictionary alloc] init];
            
            ABRecordRef person = CFArrayGetValueAtIndex(results, i);
            
            //读取firstname
            NSString *firstName = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            
            if(firstName != nil)
                [personDic setValue:firstName forKey:@"firstName"];

            //读取lastname
            NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
            if(lastname != nil)
                [personDic setValue:lastname forKey:@"lastname"];

            //读取middlename
            NSString *middlename = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
            if(middlename != nil)
                [personDic setValue:middlename forKey:@"middlename"];
            
            //        //读取prefix前缀
            //        NSString *prefix = (NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
            //        if(prefix != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",prefix];
            //        //读取suffix后缀
            //        NSString *suffix = (NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
            //        if(suffix != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",suffix];
            //        //读取nickname呢称
            //        NSString *nickname = (NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
            //        if(nickname != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",nickname];
            //        //读取firstname拼音音标
            //        NSString *firstnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
            //        if(firstnamePhonetic != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",firstnamePhonetic];
            //        //读取lastname拼音音标
            //        NSString *lastnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
            //        if(lastnamePhonetic != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",lastnamePhonetic];
            //        //读取middlename拼音音标
            //        NSString *middlenamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
            //        if(middlenamePhonetic != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlenamePhonetic];
            //        //读取organization公司
            //        NSString *organization = (NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
            //        if(organization != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",organization];
            //        //读取jobtitle工作
            //        NSString *jobtitle = (NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
            //        if(jobtitle != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",jobtitle];
            //        //读取department部门
            //        NSString *department = (NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
            //        if(department != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",department];
            //        //读取birthday生日
            //        NSDate *birthday = (NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
            //        if(birthday != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",birthday];
            //        //读取note备忘录
            //        NSString *note = (NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
            //        if(note != nil)
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",note];
            //        //第一次添加该条记录的时间
            //        NSString *firstknow = (NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
            //        NSLog(@"第一次添加该条记录的时间%@\n",firstknow);
            
            //最后一次修改該条记录的时间
            NSString *lastknow = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonModificationDateProperty));
            [personDic setValue:middlename forKey:@"lastUpdateTime"];
            //
                //获取email多值
            ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
            int emailcount = ABMultiValueGetCount(email);
            NSMutableArray * emailArray = [[NSMutableArray alloc]init];
            for (int x = 0; x < emailcount; x++)
            {
                //获取email Label
                NSString* emailLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x)));
                //获取email值
                NSString* emailContent = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(email, x));

                if (emailContent) {
                    [emailArray addObject:emailContent];
                }
                
            }
            [personDic setValue:[emailArray copy] forKey:@"email"];
            //        //读取地址多值
            //        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
            //        int count = ABMultiValueGetCount(address);
            //
            //        for(int j = 0; j < count; j++)
            //        {
            //            //获取地址Label
            //            NSString* addressLabel = (NSString*)ABMultiValueCopyLabelAtIndex(address, j);
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",addressLabel];
            //            //获取該label下的地址6属性
            //            NSDictionary* personaddress =(NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
            //            NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
            //            if(country != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"国家：%@\n",country];
            //            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
            //            if(city != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"城市：%@\n",city];
            //            NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
            //            if(state != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"省：%@\n",state];
            //            NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
            //            if(street != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"街道：%@\n",street];
            //            NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
            //            if(zip != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"邮编：%@\n",zip];
            //            NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
            //            if(coutntrycode != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"国家编号：%@\n",coutntrycode];
            //        }
            //
            //        //获取dates多值
            //        ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
            //        int datescount = ABMultiValueGetCount(dates);
            //        for (int y = 0; y < datescount; y++)
            //        {
            //            //获取dates Label
            //            NSString* datesLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
            //            //获取dates值
            //            NSString* datesContent = (NSString*)ABMultiValueCopyValueAtIndex(dates, y);
            //            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",datesLabel,datesContent];
            //        }
            //        //获取kind值
            //        CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
            //        if (recordType == kABPersonKindOrganization) {
            //            // it's a company
            //            NSLog(@"it's a company\n");
            //        } else {
            //            // it's a person, resource, or room
            //            NSLog(@"it's a person, resource, or room\n");
            //        }
            
            
            //获取IM多值
            //ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
            //for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
            //{
            //    //获取IM Label
            //    NSString* instantMessageLabel = (NSString*)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(instantMessage, l));
            //            textView.text = [textView.text stringByAppendingFormat:@"%@\n",instantMessageLabel];
            //    //获取該label下的2属性
            //    NSDictionary* instantMessageContent =(NSDictionary*) CFBridgingRelease(ABMultiValueCopyValueAtIndex(instantMessage, l));
            //    NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
            //            if(username != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"username：%@\n",username];
            //    
            //    NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
            //            if(service != nil)
            //                textView.text = [textView.text stringByAppendingFormat:@"service：%@\n",service];
            //    
            //}
            
            //获取社交多值
            ABMultiValueRef social = ABRecordCopyValue(person, kABPersonSocialProfileProperty);
            //                    NSLog(@"ABMultiValueGetCount(instantMessage) = %ld",ABMultiValueGetCount(social));
            NSMutableArray * socialArray = [[NSMutableArray alloc]init];
            for (int l = 0; l < ABMultiValueGetCount(social); l++)
            {
                //获取IM Label
                NSString* instantMessageLabel = (NSString*)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(social, l));
                //                        textView.text = [textView.text stringByAppendingFormat:@"%@\n",instantMessageLabel];
                //获取該label下的2属性
                NSDictionary* instantMessageContent =(NSDictionary*) CFBridgingRelease(ABMultiValueCopyValueAtIndex(social, l));
                NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
                //                        if(username != nil)
                //                            textView.text = [textView.text stringByAppendingFormat:@"username：%@\n",username];
                
                NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonSocialProfileServiceSinaWeibo];//kABPersonInstantMessageServiceKey
                //                        if(service != nil)
                //                            textView.text = [textView.text stringByAppendingFormat:@"service：%@\n",service];
//                NSLog(@"%@=%@=@=%@",instantMessageLabel,instantMessageContent,username,service);
                
                if (username) {
                    [socialArray addObject:username];
                }
                
            }
            [personDic setValue:[socialArray copy] forKey:@"sina"];
            
            //读取电话多值
            ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
            NSMutableArray * phoneArray = [[NSMutableArray alloc]init];
            for (int k = 0; k<ABMultiValueGetCount(phone); k++)
            {
                //获取电话Label
                NSString * personPhoneLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k)));
                //获取該Label下的电话值
                NSString * personPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k));
                [phoneArray addObject:personPhone];
                
                //                        textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",personPhoneLabel,personPhone];
            }
            [personDic setValue:phoneArray forKey:@"phone"];
            
            //        //获取URL多值
            //        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
            //        for (int m = 0; m < ABMultiValueGetCount(url); m++)
            //        {
            //            //获取电话Label
            //            NSString * urlLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
            //            //获取該Label下的电话值
            //            NSString * urlContent = (NSString*)ABMultiValueCopyValueAtIndex(url,m);
            //
            //            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",urlLabel,urlContent];
            //        }
            //
            //读取照片
            NSData *image = (NSData*)CFBridgingRelease(ABPersonCopyImageData(person));
            [personDic setValue:[UIImage imageWithData:image] forKey:@"image"];
            
            
            [AllPerson addObject:personDic];
            
        }
        CFRelease(results);
        CFRelease(addressBook);
    }
}

- (void)filterPersonTouchUp
{
    if (filterType == XD_ENUM_FILTER_TYPE_SINA) {
        
        [filterPerson removeAllObjects];
        
        for (int i=0; i<[AllPerson count]; i++) {
            if ([[[AllPerson objectAtIndex:i] objectForKey:@"sina"] count]>0) {
                [filterPerson addObject:[AllPerson objectAtIndex:i]];
            }
            
        }
        
    } else if (filterType == XD_ENUM_FILTER_TYPE_FACEBOOK) {
        
        [filterPerson removeAllObjects];
        
    } else if (filterType == XD_ENUM_FILTER_TYPE_PHOTO) {
        
        [filterPerson removeAllObjects];
        
        for (int i=0; i<[AllPerson count]; i++) {
            if ([[AllPerson objectAtIndex:i] objectForKey:@"image"] ) {
                [filterPerson addObject:[AllPerson objectAtIndex:i]];
            }
            
        }
        
        
    } else if (filterType == XD_ENUM_FILTER_TYPE_MAIL) {
    
        [filterPerson removeAllObjects];
        
        for (int i=0; i<[AllPerson count]; i++) {
            if ([[[AllPerson objectAtIndex:i] objectForKey:@"email"] count]>0) {
                [filterPerson addObject:[AllPerson objectAtIndex:i]];
            }
            
        }
        
    } else {
        
        filterPerson = [NSMutableArray arrayWithArray:AllPerson];
    }
}


//table
#pragma mark TableView Events

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"[filterPerson count] = %d",[filterPerson count]);
    countLabel.text = [NSString stringWithFormat:@"%d条",[filterPerson count]];
    return [filterPerson count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor blackColor];
        
        NSString * fName = [[filterPerson objectAtIndex:indexPath.row] objectForKey:@"firstName"];
        NSString * lName = [[filterPerson objectAtIndex:indexPath.row] objectForKey:@"lastname"];
        NSString * mName = [[filterPerson objectAtIndex:indexPath.row] objectForKey:@"middlename"];
        
        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 10, 50, 50)];
        [myImage setImage:[[filterPerson objectAtIndex:indexPath.row] objectForKey:@"image"]];
        myImage.opaque = YES;
        
//        cell.imageView.image = [[AllPerson objectAtIndex:indexPath.row] objectForKey:@"image"];
        NSArray * socialArray = [[filterPerson objectAtIndex:indexPath.row] objectForKey:@"sina"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@%@\t%@",
                               lName ? lName : @"",
                               mName ? mName : @"",
                               fName ? fName : @"",
                               [socialArray count]>0 ? [socialArray objectAtIndex:0] :@""
                               ];
        NSArray * phones = [[filterPerson objectAtIndex:indexPath.row] objectForKey:@"phone"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[phones count]>0?[phones objectAtIndex:0]:@""];
        [cell addSubview:myImage];
        
    }
    return cell;
}

//picker
#pragma mark Picker

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * returnStr = @"全部";
    
	switch (row) {
        case 1:
            returnStr = @"新浪";
            break;
        case 2:
            returnStr = @"Facebook";
            break;
        case 3:
            returnStr = @"有头像";
            break;
        case 4:
            returnStr = @"有邮件";
            break;
            
        default:
            break;
    }
    
	
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return 5;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerSelectedRow = row;
}

#pragma mark Picker Events

-(void)DPCancelButtonTapped{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    ClassPickerBGView.frame=CGRectMake(0, 600, 320, 216+42);
    [UIView commitAnimations];
    
    
}


-(void)DPOKButtonTapped{
    
    switch (pickerSelectedRow) {
        case 1:
            filterType = XD_ENUM_FILTER_TYPE_SINA;
            break;
        case 2:
            filterType = XD_ENUM_FILTER_TYPE_FACEBOOK;
            break;
        case 3:
            filterType = XD_ENUM_FILTER_TYPE_PHOTO;
            break;
        case 4:
            filterType = XD_ENUM_FILTER_TYPE_MAIL;
            break;
        default:
            filterType = XD_ENUM_FILTER_TYPE_ALL;
            break;
    }
    
    [self filterPersonTouchUp];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    ClassPickerBGView.frame=CGRectMake(0, 600, 320, 216+42);
    [UIView commitAnimations];
    
    
    [listView reloadData];
    
}

#pragma mark Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
