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

//extern NSString* CTSettingCopyMyPhoneNumber();


//+(NSString *) phoneNumber {
//    NSString *phone = CTSettingCopyMyPhoneNumber();
//    
//    return phone;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = info.subscriberCellularProvider;
//    NSLog(@"carrier:%@", [carrier description]);
    
//    [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(showPhoneNumber:) userInfo:nil repeats:YES];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showPhoneNumber:) userInfo:nil repeats:YES];
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSDirectoryEnumerator *dirnum = [[NSFileManager defaultManager] enumeratorAtPath: @"/private/"];
//    NSString *nextItem = [NSString string];
//    while( (nextItem = [dirnum nextObject])) {
//        if ([[nextItem pathExtension] isEqualToString: @"db"] ||
//            [[nextItem pathExtension] isEqualToString: @"sqlitedb"]) {
//            if ([fileManager isReadableFileAtPath:nextItem]) {
//                NSLog(@"%@", nextItem);
//            }
//        }
//    }
    
    //
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20+44, 320, self.view.bounds.size.height-44-20) style:UITableViewStylePlain];
	tableView.dataSource = self;
	tableView.delegate = self;
    [self.view addSubview:tableView];
    
    AllPerson = [[NSMutableArray alloc] init];
    
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        
        // we're on iOS 6
        NSLog(@"on iOS 6 or later, trying to grant access permission");
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        
        NSLog(@"on iOS 5 or older, it is OK");
        accessGranted = YES;
    }
    
    if (accessGranted) {
        
        NSLog(@"we got the access right");
        
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        for(int i = 0; i < CFArrayGetCount(results); i++)
        {
            NSMutableDictionary * personDic = [[NSMutableDictionary alloc] init];
            
            ABRecordRef person = CFArrayGetValueAtIndex(results, i);
            
            //读取firstname
            NSString *firstName = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            
//            if(firstName != nil)
                [personDic setValue:firstName forKey:@"firstName"];
//                textView.text = [textView.text stringByAppendingFormat:@"\n姓名：%@\n",personName];
            //读取lastname
            NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
//            if(lastname != nil)
                [personDic setValue:lastname forKey:@"lastname"];
//                textView.text = [textView.text stringByAppendingFormat:@"%@\n",lastname];
            //读取middlename
            NSString *middlename = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
//            if(middlename != nil)
                [personDic setValue:middlename forKey:@"middlename"];
            
            //Facebook
//            NSString *facebook = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonInstantMessageServiceFacebook));
            
//            CFErrorRef error = NULL;
//            ABMutableMultiValueRef im = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
//            NSMutableDictionary *imDict = [[NSMutableDictionary alloc] init];
//            [imDict setObject:(NSString*)kABPersonInstantMessageServiceFacebook forKey:(NSString*)kABPersonInstantMessageServiceKey];
//            
//            NSLog(@"%@_%@_%@",firstName,middlename,lastname);
//            NSLog(@"personDic = %@",personDic);
//            NSLog(@"AllPerson = %@",AllPerson);
//                textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlename];
            
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
            //        //最后一次修改該条记录的时间
            //        NSString *lastknow = (NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
            //        NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
            //
            //        //获取email多值
            //        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
            //        int emailcount = ABMultiValueGetCount(email);
            //        for (int x = 0; x < emailcount; x++)
            //        {
            //            //获取email Label
            //            NSString* emailLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
            //            //获取email值
            //            NSString* emailContent = (NSString*)ABMultiValueCopyValueAtIndex(email, x);
            //            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",emailLabel,emailContent];
            //        }
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
            //
            //
                    //获取IM多值
                    ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
            NSLog(@"ABMultiValueGetCount(instantMessage) = %d",ABMultiValueGetCount(instantMessage));
                    for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
                    {
                        //获取IM Label
                        NSString* instantMessageLabel = (NSString*)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(instantMessage, l));
//                        textView.text = [textView.text stringByAppendingFormat:@"%@\n",instantMessageLabel];
                        //获取該label下的2属性
                        NSDictionary* instantMessageContent =(NSDictionary*) CFBridgingRelease(ABMultiValueCopyValueAtIndex(instantMessage, l));
                        NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
//                        if(username != nil)
//                            textView.text = [textView.text stringByAppendingFormat:@"username：%@\n",username];

                        NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonSocialProfileServiceSinaWeibo];//kABPersonInstantMessageServiceKey
//                        if(service != nil)
//                            textView.text = [textView.text stringByAppendingFormat:@"service：%@\n",service];
                        NSLog(@"%@=%@=@=%@",instantMessageLabel,instantMessageContent,username,service);
                    }

                    //读取电话多值
                    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
                    for (int k = 0; k<ABMultiValueGetCount(phone); k++)
                    {
                        //获取电话Label
                        NSString * personPhoneLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k)));
                        //获取該Label下的电话值
                        NSString * personPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k));
                        [personDic setValue:personPhone forKey:@"phone"];
//                        textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",personPhoneLabel,personPhone];
                    }
                    
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
//                UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
//                [myImage setImage:[UIImage imageWithData:image]];
//                myImage.opaque = YES;
//                [textView addSubview:myImage];
                [personDic setValue:[UIImage imageWithData:image] forKey:@"image"];
            
            [AllPerson addObject:personDic];
            
        }
        CFRelease(results);
        CFRelease(addressBook);
    }
    
    
    
    
    

}

//- (void)showPhoneNumber:(NSTimer*)theTimer
//{
//    NSLog(@"%@",
//          [[NSUserDefaults standardUserDefaults] valueForKey:@"SBFormattedPhoneNumber"]);
//}

//table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"[AllPerson count] = %d",[AllPerson count]);
    return [AllPerson count];
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
        
        NSString * fName = [[AllPerson objectAtIndex:indexPath.row] objectForKey:@"firstName"];
        NSString * lName = [[AllPerson objectAtIndex:indexPath.row] objectForKey:@"lastname"];
        NSString * mName = [[AllPerson objectAtIndex:indexPath.row] objectForKey:@"middlename"];
        
        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 10, 50, 50)];
        [myImage setImage:[[AllPerson objectAtIndex:indexPath.row] objectForKey:@"image"]];
        myImage.opaque = YES;
        
//        cell.imageView.image = [[AllPerson objectAtIndex:indexPath.row] objectForKey:@"image"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@%@",
                               lName ? lName : @"",
                               mName ? mName : @"",
                               fName ? fName : @""
                               ];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[[AllPerson objectAtIndex:indexPath.row] objectForKey:@"phone"]];
        [cell addSubview:myImage];
        
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
