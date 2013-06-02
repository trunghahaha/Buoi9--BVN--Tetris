//
//  MenuView.m
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/2/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "MenuView.h"
#import "MainGameView.h"
@interface MenuView ()

@end

@implementation MenuView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startBtn:(id)sender {
    MainGameView *mainGameView = [[MainGameView alloc] initWithNibName:nil bundle:NULL];
    [self presentViewController:mainGameView animated:YES completion:^{
        //[self removeFromParentViewController];
    }];
}

@end
