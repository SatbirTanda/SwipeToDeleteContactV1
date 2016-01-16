#import "ContactsUI/CNContactListViewController.h"
#import "ContactsUI/CNContactListTableViewCell.h"
#import "ContactsUI/CNContactDeleteContactAction.h"
#import "Contacts/CNContact.h"
#import "Contacts/CNMutableContact.h"
#import "Contacts/CNSaveRequest.h"
#import "ContactsUI/CNContactDataSource.h"


%hook CNContactListViewController //THIS IS A SUBCLASS OF A UITABLEVIEWCONTROLLER

- (BOOL)tableView:(id)arg1 canEditRowAtIndexPath:(id)arg2
{
	%orig;
	return YES;
}

%new
 -(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 											forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
   		UIAlertView *x = [[UIAlertView alloc] initWithTitle:@"Delete this contact!" 
					    message:@"Figure out how to delete this contact"
					   delegate:nil
				  cancelButtonTitle:nil
				  otherButtonTitles:@"... okay?", nil];
		[x show];
    }
}

%end