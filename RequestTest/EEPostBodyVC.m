//
//  PostBodyVC.m
//  RequestTest
//
//  Created by Melany on 6/10/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "EEPostBodyVC.h"

@interface EEPostBodyVC ()

@end

@implementation EEPostBodyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _userName;
    self.titleLable.text = _postTitle;
    self.bodyLable.text = _postBody;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
