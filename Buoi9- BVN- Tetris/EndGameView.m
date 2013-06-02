//
//  EndGameView.m
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/2/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "EndGameView.h"
#import "MainGameView.h"
#import "MenuView.h"
@interface EndGameView ()

@end

@implementation EndGameView

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
- (IBAction)menuBtnTouch:(id)sender {
    MenuView *mnv = [[MenuView alloc] initWithNibName:nil bundle:NULL];
    [self presentViewController: mnv animated:YES completion:^{
        [self removeFromParentViewController];
    }];
}
- (IBAction)tryAgainTouch:(id)sender {
    MainGameView *mgv = [[MainGameView alloc] initWithNibName:nil bundle:NULL];
    [self presentViewController: mgv animated:YES completion:^{
        [self removeFromParentViewController];
    }];
}

@end
