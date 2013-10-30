//
//  BaseToolbar.h
//  AddressBook
//
//  Created by duan on 13-10-29.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#ifndef AddressBook_BaseToolbar_h
#define AddressBook_BaseToolbar_h



#endif


@interface BaseToolbar : UIToolbar

@end

@implementation BaseToolbar

- (void)drawRect:(CGRect)rect {
    // do nothing
}

- (id)initWithFrame:(CGRect)aRect {
    if ((self = [super initWithFrame:aRect])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}
@end