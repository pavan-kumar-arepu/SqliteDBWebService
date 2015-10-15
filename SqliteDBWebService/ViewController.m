//
//  ViewController.m
//  SqliteDBWebService
//
//  Created by Pavankumar Arepu on 12/10/2015.
//  Copyright (c) 2015 Pavankumar Arepu. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"



@interface ViewController ()
{
    DetailViewController *dVC;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Retriving model Class instance
   model = [Model sharedModel];
    
    //Creating DB at Document Path
    [model creatingDB];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)validateLogin:(id)sender
{
  
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BOOL isValidateUser = [model validateLoinCredentials:self.userNameField.text andPassword:self.passwordTextField.text];
    
    if (!isValidateUser)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Alert" message:@"Not a Valid User" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}] ;
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else
    {if ([[segue identifier] isEqualToString:@"EmpIdentifier"])
    {
        self->dVC = [segue destinationViewController];
    }
    }
    
    
    
}



@end

