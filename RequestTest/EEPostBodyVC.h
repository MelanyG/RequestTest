//
//  PostBodyVC.h
//  RequestTest
//
//  Created by Melany on 6/10/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEPostBodyVC : UIViewController

@property (strong, nonatomic)NSString *postTitle;
@property (strong, nonatomic)NSString *postBody;
@property (strong, nonatomic)NSString *userName;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *bodyLable;



@end
