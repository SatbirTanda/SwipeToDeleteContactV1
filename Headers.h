#import <UIKit/UITableViewCell.h>


@class NSString, NSDateComponents, NSDate, NSData, NSArray, CNActivityAlert, NSDictionary, NSSet, SGRecordId;


@interface CNContact : NSObject 

@end


@class NSArray, NSString, NSDictionary, CNContactStore, CNContactFilter, CNContact, CNContactFormatter;
@protocol CNContactDataSource <NSObject, NSCopying>



@property (nonatomic,readonly) NSArray * contacts; 
@property (nonatomic,readonly) CNContactStore * store; 


@end





@protocol CNContactDataSource, CNContactListViewControllerDelegate;
@class NSObject, _UIContentUnavailableView, CNContact, NSString, CNContactFormatter, UISearchController, UISearchBar, CNContactListBannerView, CNAvatarCardController, NSArray;

@interface CNContactListViewController : UITableViewController  <UIAlertViewDelegate>


-(id)initWithDataSource:(id)arg1 ;
- (void)deleteContact;

@end

@class NSMutableDictionary, NSString, NSMutableArray, NSDictionary, NSArray;

@interface CNSaveRequest : NSObject 

-(void)deleteContact:(id)arg1 ;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@class NSArray, NSString, NSData, NSDateComponents, CNActivityAlert, NSDate, CNContact, NSSet, NSDictionary;

@interface CNMutableContact : CNContact 

	
-(void)setSnapshot:(CNContact *)arg1 ;

@end



@interface UITableViewRowData : NSObject
- (NSInteger)globalRowForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface UITableView (SwipeToDeleteContact)
- (UITableViewRowData *)_rowData;
@end



@interface CNContactStoreDataSource : NSObject  {

	CNContactStore* _store;
	NSArray* _keysToFetch;
	CNContact* _meContact;

}

@property (nonatomic,retain) CNContactStore * store;                                                       //@synthesize store=_store - In the implementation block


-(NSArray *)contacts;

@end

@interface CNContactStore : NSObject



-(BOOL)executeSaveRequest:(id)arg1 error:(id*)arg2 ;

@end


