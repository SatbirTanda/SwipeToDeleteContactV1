

//#import "ContactsUI/CNContactListViewController.h"  // MANDATORY HEADER

#import <UIKit/UIKit.h>

#import "Headers.h"

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
static BOOL useAlarm = YES; //Like Confirm 



%hook CNContactListViewController //THIS IS A SUBCLASS OF A UITABLEVIEWCONTROLLER

-(id)initWithDataSource:(id)arg1
{
	
	dataSource = arg1;
	

	return %orig;

}


- (BOOL)tableView:(id)arg1 canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([[[self tableView] _rowData] globalRowForRowAtIndexPath:indexPath] == 0  && [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.mobilephone"]) {

	
		return NO; 

	}

	
	return YES;

}


%new

 -(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 					    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
    	  
    	globalRow = [[tableView _rowData] globalRowForRowAtIndexPath:indexPath];

    	
    	
    	if (useAlarm) {


   		UIAlertView *x = [[UIAlertView alloc] initWithTitle:@"SwipeToDeleteContact!" 
					    message:@"Really delete this contact?"
					    delegate:self
				  		cancelButtonTitle:@"Cancel"
				  		otherButtonTitles:@"YES", nil];
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
