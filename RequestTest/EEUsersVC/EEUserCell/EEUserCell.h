//
//  EEUserCellTableViewCell.h
//  RequestTest
//
//  Created by Melany on 6/13/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EECellDelegate <NSObject>
- (void) cellDelegateMethod: (NSIndexPath *) index;
@end 


@interface EEUserCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *index;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userCity;
@property (weak, nonatomic) IBOutlet UILabel *userCompany;
@property (nonatomic, weak) id <EECellDelegate> delegate;
//@property (strong, nonatomic) NSNumber *lon;
//@property (strong, nonatomic) NSNumber *lat;

- (IBAction)locationPressed:(id)sender;
- (void) transferToLocation;
@end
