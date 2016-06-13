//
//  EEUserCellTableViewCell.m
//  RequestTest
//
//  Created by Melany on 6/13/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "EEUserCell.h"
#import "EELocationVC.h"

@implementation EEUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)locationPressed:(id)sender {
    [self transferToLocation];
    
}

- (void) transferToLocation {
    [self.delegate cellDelegateMethod:self.index]; //this will call the method implemented in your other class
}


//#pragma mark - Segues
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"map"]) {
//        EELocationVC *controller = segue.destinationViewController;
//        controller.longit = self.lon;
//        controller.latitud = self.lat;
//        controller.city = self.userCity.text;
//
//    }
//}

@end
