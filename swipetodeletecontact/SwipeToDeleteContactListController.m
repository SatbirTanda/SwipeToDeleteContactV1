//
//  SwipeToDeleteContactListController.m
//  SwipeToDeleteContact
//
//  Created by Rene Kahle on 19.01.2016.
//  Copyright (c) 2016 Rene Kahle. All rights reserved.
//


#import "Preferences/PSListController.h"





@interface SwipeToDeleteContactListController : PSListController

@end

@implementation SwipeToDeleteContactListController

- (id)specifiers {
	if (_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"SwipeToDeleteContact" target:self] retain];
	}
    
	return _specifiers;
}

-(void)donation {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=9ARRFBVXMQPAG"]];
    
}

-(void)twitter {
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=DPDDEPP"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=DPDDEPP"]];
	} else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/DPDDEPP"]];
	}
}



-(void)dimMe

{


[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/org.thebigboss.dimme"]]; //; cydia://package/

}

-(void)noMore

{


[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/org.thebigboss.nomoremissed"]]; //; cydia://package/

}
-(void)stopalarm8
{


[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/org.thebigboss.stopalarmios8"]]; //; cydia://package/

}
@end
