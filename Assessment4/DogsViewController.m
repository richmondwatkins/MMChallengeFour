//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "Dog.h"
@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *dogs;
@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";

    self.dogs = [self.owner.dog allObjects];
}

-(void)viewDidAppear:(BOOL)animated{
    self.dogs = [self.owner.dog allObjects];
    [self.dogsTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    Dog *dog = [self.dogs objectAtIndex:indexPath.row];
A
    cell.textLabel.text = dog.name;
    cell.detailTextLabel.text = dog.breed;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddDogViewController *addDogViewCtrl = segue.destinationViewController;
    addDogViewCtrl.owner = self.owner;

    if ([segue.identifier isEqualToString: @"EditDogSegue"])
    {
        addDogViewCtrl.dog = [self.dogs objectAtIndex:[self.dogsTableView indexPathForSelectedRow].row];
    }

}


@end
