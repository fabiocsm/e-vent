//
//  CreateCodeViewController.m
//  e-vent
//
//  Created by Fábio C.S. Miranda on 11/5/14.
//  Copyright (c) 2014 Fábio C.S. Miranda. All rights reserved.
//

#import "CreateCodeViewController.h"
#import "ImageViewController.h"

@interface CreateCodeViewController()

@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerStart;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerEnd;

@property NSString *titleEvent;
@property NSDate *dateStart;
@property NSDate *dateEnd;
@end

@implementation CreateCodeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.datePickerStart addTarget:self action:@selector(datePickerStartChanged:) forControlEvents:UIControlEventValueChanged];
    [self.datePickerEnd addTarget:self action:@selector(datePickerEndChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)datePickerStartChanged:(UIDatePicker *)datePicker{
    self.dateStart = [datePicker date];
}

- (void)datePickerEndChanged:(UIDatePicker *)datePicker{
    self.dateEnd = [datePicker date];
}

- (IBAction)buttonGenerate:(UIButton *)sender {
    self.titleEvent = self.textFieldTitle.text;
}

-(NSString *)getCodeURL{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmssZ"];
    
    NSString *dtStart = [dateFormatter stringFromDate:self.dateStart];
    
    NSString *dtEnd = [dateFormatter stringFromDate:self.dateEnd];
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://api.qrserver.com/v1/create-qr-code/?color=000000&bgcolor=FFFFFF&data=BEGIN%3AVEVENT%0ASUMMARY%3A%@%0ADTSTART%3A%@%0ADTEND%3A%@%0AEND%3AVEVENT&qzone=4&margin=0&size=300x300&ecc=L", self.titleEvent, dtStart, dtEnd];
    NSLog(@"%@",url);
    return url;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        ImageViewController *ivc = (ImageViewController *)segue;
        NSURL *url = [[NSURL alloc] initWithString:[self getCodeURL]];
        ivc.imageURL = url;
}


@end
