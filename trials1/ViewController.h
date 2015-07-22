//
//  ViewController.h
//  trials1
//
//  Created by patrick debois on 21/07/15.
//  Copyright (c) 2015 patrick debois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

- (IBAction)doit:(id)sender;

@end

