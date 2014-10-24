//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "PersonRetrieval.h"
#import "AddDogViewController.h"
#import "DogsViewController.h"
#import "Person.h"
#import "ColorSetting.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property (nonatomic)  NSArray *owners;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarColor];

    self.title = @"Dog Owners";

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *opened = [userDefaults objectForKey:@"DefaultsLoaded"];
    if (opened.integerValue == 1) {
        [self loadOwners];
    }else{
        [PersonRetrieval retrieveDogOwners:^(NSArray *people) {
            for (NSString *person in people) {
                Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];

                newPerson.name = person;
                [self.managedObjectContext save:nil];
            }
            [self loadOwners];
        }];
    }

    NSNumber *defaultsLoaded = @1;
    [userDefaults setObject:defaultsLoaded forKey:@"DefaultsLoaded"];
    [userDefaults synchronize];
}

-(void)setBarColor{
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"barColor"];
    UIColor *barColor = (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    self.navigationController.navigationBar.tintColor = barColor;
}


-(void)loadOwners{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    self.owners = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    [self.myTableView reloadData];
}

-(void)setOwners:(NSArray *)owners{
    _owners = owners;
    [self.myTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.owners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    Person *person = [self.owners objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }

    NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:self.navigationController.navigationBar.tintColor];
    [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"barColor"];

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DogsViewController *dogViewCtrl = segue.destinationViewController;
    dogViewCtrl.owner =[self.owners objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
}

@end
