
#import <UIKit/UIKit.h>
#import "Headers.h"
#define IS_OS_9_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define APPID @"com.packetfahrer.swipetodeletecontact"
#define DEFAULT_ENABLED YES
#define PREFS_ENABLED_KEY @"useAlarm"

#define Enabled ([preferences objectForKey: PREFS_ENABLED_KEY] ? [[preferences objectForKey: PREFS_ENABLED_KEY] boolValue] : DEFAULT_ENABLED)

#define DEFAULT_USEALARM YES
#define PREFS_USEALARM_KEY @"useAlarm"

#define useAlarm ([preferences objectForKey: PREFS_USEALARM_KEY] ? [[preferences objectForKey: PREFS_USEALARM_KEY] boolValue] : DEFAULT_USEALARM)


#define LocalizationsDirectory @"/Library/Application Support/SwipeToDeleteContact/Localizations"
#define LOCALIZED_TITEL  [[NSBundle bundleWithPath:LocalizationsDirectory]localizedStringForKey:@"Swipe to Delete!" value:@"Swipe to Delete!" table:nil]
#define LOCALIZED_MESSAGE [[NSBundle bundleWithPath:LocalizationsDirectory]localizedStringForKey:@"Really delete this Contact?" value:@"Really delete this Contact?" table:nil]
#define LOCALIZED_CANCEL [[NSBundle bundleWithPath:LocalizationsDirectory]localizedStringForKey:@"Cancel" value:@"Cancel" table:nil]
#define LOCALIZED_YES [[NSBundle bundleWithPath:LocalizationsDirectory]localizedStringForKey:@"Yes" value:@"Yes" table:nil]


//  THESE HEADERS MIGHT BE THE KEY TO DELETION
/*

#import "ContactsUI/CNContactListTableViewCell.h"
#import "ContactsUI/CNContactDeleteContactAction.h"
#import "Contacts/CNContact.h"
#import "Contacts/CNMutableContact.h"
#import "Contacts/CNSaveRequest.h"
#import "ContactsUI/CNContactDataSource.h"
*/


static NSInteger globalRow = -1;
static CNContactStoreDataSource *dataSource;
static CNContactStore *store;

// static BOOL useAlarm = YES; //Like Confirm 

static NSDictionary *preferences = nil;


void loadPreferences() {
	
	
	if (preferences) {
		[preferences release];
		 preferences = nil;


	}
	
	if (IS_OS_9_OR_LATER) { 

		
		NSArray *keyList = [(NSArray *)CFPreferencesCopyKeyList((CFStringRef)APPID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost) autorelease];
		preferences = (NSDictionary *)CFPreferencesCopyMultiple((CFArrayRef)keyList, (CFStringRef)APPID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

	}


}	

%group main


%hook CNContactListViewController //THIS IS A SUBCLASS OF A UITABLEVIEWCONTROLLER

-(id)initWithDataSource:(id)arg1
{
	
	dataSource = arg1;
	

	return %orig;

}


- (BOOL)tableView:(id)arg1 canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (Enabled) {

	if ([[[self tableView] _rowData] globalRowForRowAtIndexPath:indexPath] == 0  && [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mobilephone"]) {

	
		return NO; 

	}


	return YES;

	}

	return %orig;

}


%new

 -(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 					    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
    	  
    	globalRow = [[tableView _rowData] globalRowForRowAtIndexPath:indexPath];

    	
    	
    	if (useAlarm) {


   		UIAlertView *x = [[UIAlertView alloc] initWithTitle:LOCALIZED_TITEL
					    message:LOCALIZED_MESSAGE
					    delegate:self
				  		cancelButtonTitle:LOCALIZED_CANCEL
				  		otherButtonTitles:LOCALIZED_YES, nil];
   						[x setTag:0075];
						[x show];


					
					return;
		
    	}

    	[self deleteContact];

    }

}


%new(v@:@i)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {


 	
	
		if ([alertView tag] == 0075) {
		
			if (buttonIndex == 1) {

			[self deleteContact];
		
			} else {

				self.tableView.editing = NO;
				

			}

		
		}


	
}

%new(v@:)

- (void)deleteContact {

		

		store = [dataSource store];

    		CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];

    	
    		CNMutableContact *updatedContact = [[dataSource.contacts objectAtIndex:globalRow] mutableCopy];

    		CNContact *c = [dataSource.contacts objectAtIndex:globalRow];
    	

    		[updatedContact setSnapshot:c];


		[saveRequest deleteContact:updatedContact];


		[store executeSaveRequest:saveRequest  error:nil] ;
		
		self.tableView.editing = NO;

	
}

%end

%end


%ctor {
	@autoreleasepool {
		
		%init(main);


		loadPreferences();

    	
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
											NULL,
											(CFNotificationCallback)loadPreferences,
											CFSTR("com.packetfahrer.SwipeChanged"),
											NULL,
											CFNotificationSuspensionBehaviorDeliverImmediately);
	}

}

