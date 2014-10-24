//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "Person.h"
#import "Dog.h"
@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property (strong, nonatomic) IBOutlet UIButton *saveOrUpdateButton;
@property BOOL isUpdating;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@end

@implementation AddDogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";

    self.deleteButton.hidden = YES;
    if (self.dog) {
        self.deleteButton.hidden = NO;
        [self populateLabels];
    }
}

-(void)populateLabels{
    [self.saveOrUpdateButton setTitle:@"Update" forState:UIControlStateNormal];
    self.isUpdating = YES;
    self.nameTextField.text = self.dog.name;
    self.breedTextField.text = self.dog.breed;
    self.colorTextField.text = self.dog.color;
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{

    if (self.isUpdating) {
        self.dog.name = self.nameTextField.text;
        self.dog.breed = self.breedTextField.text;
        self.dog.color = self.colorTextField.text;
        [self.dog.managedObjectContext save:nil];
    }else{
        Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.owner.managedObjectContext];
        dog.color = self.colorTextField.text;
        dog.name = self.nameTextField.text;
        dog.breed = self.breedTextField.text;

        [self.owner addDogObject:dog];

        [self.owner.managedObjectContext save:nil];
        [self.owner.managedObjectContext save:nil];

    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onDeleteButtonPressed:(id)sender {
    [self.owner.managedObjectContext deleteObject:self.dog];
    [self.owner.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
