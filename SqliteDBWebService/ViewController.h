//
//  ViewController.h
//  SqliteDBWebService
//
//  Created by Pavankumar Arepu on 12/10/2015.
//  Copyright (c) 2015 Pavankumar Arepu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "sqlite3.h"

@interface ViewController : UIViewController
{
    Model *model;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)validateLogin:(id)sender;

@end

