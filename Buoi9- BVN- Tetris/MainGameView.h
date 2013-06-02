//
//  MainGameView.h
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/1/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block.h"
#import "config.h"
#import "Score.h"
@interface MainGameView : UIViewController
{
    Box * _bs[maxRow][maxColumn];
}
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (nonatomic, strong) Block *blk;
@property (nonatomic, strong) Block *nextBlk;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (nonatomic, strong) NSMutableArray *boxs;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (nonatomic, strong) Score *s;
@end
