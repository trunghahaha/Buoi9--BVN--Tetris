//
//  MainGameView.m
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/1/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "MainGameView.h"
#import "Box.h"
#import "Block.h"
#import "config.h"
#import "EndGameView.h"
@interface MainGameView ()
{  
}
@end

@implementation MainGameView
{
    NSTimer *timer1;
    int _nextRan;
    NSString * _color;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.s = [[Score alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // init next block
    self.nextBlk = [[Block alloc] init];
    self.boxs = [[NSMutableArray alloc] init];
    memset(_bs, 0, sizeof(_bs));
    [self.changeBtn addTarget:self action:@selector(changeShape) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn addTarget:self action:@selector(moveLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(moveRight) forControlEvents:UIControlEventTouchUpInside];
    [self.downBtn addTarget:self action:@selector(fastDown) forControlEvents:UIControlEventTouchUpInside];
    int ran = arc4random() % 13;
    NSString *c = [self chooseColor];
    [self initShape: ran withColor:c];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *) chooseColor {
    NSString *color = nil;
    int ran = arc4random()%6;
    switch (ran) {
        case 0:
            color = @"green";
            break;
        case 1:
            color = @"cyan";
            break;
        case 2:
            color = @"magenta";
            break;
        case 3:
            color = @"orange";
            break;
        case 4:
            color = @"red";
            break;
        case 5:
            color = @"yellow";
            break;
        default:
            color = @"green";
            break;
    }
    return color;
}
- (void) initShape: (int) nextRan withColor: (NSString *) color{
    Block *bl = [[Block alloc] initWithColor:color];
    [bl createShape:nextRan andAt:boxY :boxX];
    self.blk = bl;
    [self.blk addViewTo:self.view];
    if([timer1 isValid])
        [timer1 invalidate];
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(moveDown) userInfo:nil repeats:YES];
    
    // display next block
    _nextRan = arc4random() % 13;
    _color = [self chooseColor];
    for(Box *b in self.nextBlk.block){
        [b.box removeFromSuperview];
    }
    self.nextBlk = nil;
    self.nextBlk = [[Block alloc] initWithColor:_color];
    [self.nextBlk createShape:_nextRan andAt: 220:234];
    [self.nextBlk addViewTo:self.view];
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self initShape];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
/**
 I 0 1
 L 3 4 5 6
 T 8 9 10 7
 Z 11 12
 */
/* checking style of shape and its status, we will have next status of that shape*/
- (void) changeShape {
    switch (self.blk.status) {
        case 0:
            if([self.blk.style isEqualToString:@"I"]){
                [self.blk changeShapeTo:1];
            }else if([self.blk.style isEqualToString:@"L"]){
                [self.blk changeShapeTo:4];
            }else if([self.blk.style isEqualToString:@"T"]){
                [self.blk changeShapeTo:9];
            }else if([self.blk.style isEqualToString:@"Z"]){
                [self.blk changeShapeTo:12];
            }
            break;
        case 1:
            if([self.blk.style isEqualToString:@"I"]){
                [self.blk changeShapeTo:0];
            }else if([self.blk.style isEqualToString:@"L"]){
                [self.blk changeShapeTo:5];
            }else if([self.blk.style isEqualToString:@"T"]){
                [self.blk changeShapeTo:10];
            }else if([self.blk.style isEqualToString:@"Z"]){
                [self.blk changeShapeTo:11];
            }
            break;
        case 2:
            if([self.blk.style isEqualToString:@"L"]){
                [self.blk changeShapeTo:6];
            }else if([self.blk.style isEqualToString:@"T"]){
                [self.blk changeShapeTo:7];
            }
            break;
        case 3:
            if([self.blk.style isEqualToString:@"L"]){
                [self.blk changeShapeTo:3];
            }else if([self.blk.style isEqualToString:@"T"]){
                [self.blk changeShapeTo:8];
            }
            break;
        default:
            break;
    }
    [self fixOutOfScreen];
    [self fixBoxConflict];
}
// auto move down
/**
 we have 2 situations which the box can not be moved
 - this box is on the ground
 - this box is on the other
 */

- (bool) checkGround {
    bool check = NO;
    for(Box *b in self.blk.block){
        int y = b.box.frame.origin.y /boxSide +1;
        int x = b.box.frame.origin.x /boxSide;
        if(_bs[y][x]!=0)
            check = YES;
    }
    return check;
}
- (void) moveDown {
    bool check = NO;
    check = [self checkGround];
    if(!check)
       check = [self putBoxToRight];
    
    if(check){
        for(Box *b in self.blk.block) {
            [self.boxs addObject:b];
        }
        [UIView animateWithDuration:1.0f animations:^{
            //NSLog(@"aaa");
        } completion:^(BOOL finished) {
            [self reInitBlock];
        }];
    }else
    {   for(Box *currentB in self.blk.block){
            CGPoint p;
            p.x = currentB.box.center.x;
            p.y = currentB.box.center.y + boxSide;
            currentB.box.center = p;
        }
    }
}
- (void) reInitBlock {
    //NSLog(@"%d", self.boxs.count);
    [self addToMatrix:self.blk];
    [self checkRow];
    [self checkGameOver];
    self.blk = nil;
    [self initShape: _nextRan withColor:_color];
}
// put box to right position on ground
- (bool) putBoxToRight {
    bool check = NO;
    for(Box *currentB in self.blk.block){
        float y = currentB.box.center.y;
        if(y >= maxRow*boxSide - boxSide/2) {
            check = YES;
            float off = y- (maxRow* boxSide - boxSide/2);
            for(Box *b in self.blk.block) {
                b.box.center = CGPointMake(b.box.center.x, b.box.center.y - off);
            }
        }
    }
    return check;
}
// fix out of screen when change shape
- (bool) fixOutOfScreen {
    bool check = NO;
    float x;
    for(Box *currentB in self.blk.block){
        x = currentB.box.center.x;
        if(x > maxX - boxSide ) {
            check = YES;
            int off = boxSide * ((x- ( maxX - boxSide/2))/ boxSide);
            for(Box *b in self.blk.block) {
                b.box.center = CGPointMake(b.box.center.x - off, b.box.center.y);
            }
        }else if(x < minX + boxSide ) {
            check = YES;
            float off = boxSide * ((( minX + boxSide/2) - x) / boxSide);
            for(Box *b in self.blk.block) {
                b.box.center = CGPointMake(b.box.center.x + off, b.box.center.y);
            }
        }
    }
    return check;
}
// fix when this box conflict with the other after changing shape
- (void) fixBoxConflict {
    int count = 0;
    for(Box *b in self.blk.block){
        int y = b.box.frame.origin.y /boxSide;
        int x = b.box.frame.origin.x /boxSide;
        if(_bs[y][x]!=0)
            count++;
    }
    if(count!=0){
        for(Box *b in self.blk.block){
            b.box.center = CGPointMake(b.box.center.x, b.box.center.y - (count+1)*boxSide);
        }
    }
}
// move left
/**
 we have 2 situations which the box can not be moved
 - this box tend to be out of screen
 - one side of this box is next to the other box of boxs  set
 */
- (bool) checkBoxConflictLeft{
    bool check = NO;
    if(self.boxs.count > 0){
        for(Box *b in self.boxs){
            for(Box *curB in self.blk.block){
                if(b.box.center.x + boxSide == curB.box.center.x && b.box.center.y - boxSide < curB.box.center.y &&   curB.box.center.y < b.box.center.y + boxSide){
                    check = YES;
                    break;
                }
            }
        }
    }
    return  check;
}
- (bool) checkBoxConflictRight{
    bool check = NO;
    if(self.boxs.count > 0){
        for(Box *b in self.boxs){
            for(Box *curB in self.blk.block){
                if(b.box.center.x - boxSide == curB.box.center.x && b.box.center.y - boxSide < curB.box.center.y &&   curB.box.center.y < b.box.center.y + boxSide){
                    check = YES;
                    break;
                }
            }
        }
    }
    return check;
}
- (void) moveLeft {
    // check variable show me if the box can be moved
    [self.leftBtn removeTarget:self action:@selector(moveLeft) forControlEvents:UIControlEventTouchUpInside];
    bool check = NO;
    check = [self checkBoxConflictLeft];
    //check = [self fixOutOfScreen];
    for(Box *currentB in self.blk.block){
        CGPoint p;
        p.x = currentB.box.center.x;
        if(p.x <= minX + boxSide) {
            check = YES;
            break;
        }
    }
    if(!check){
        for(Box *currentB in self.blk.block){
            CGPoint p;
            p.x = currentB.box.center.x - boxSide;
            p.y = currentB.box.center.y;
            currentB.box.center = p;
        }
    }
    [self.leftBtn addTarget:self action:@selector(moveLeft) forControlEvents:UIControlEventTouchUpInside];
}
// move right
- (void) moveRight {
    [self.rightBtn removeTarget:self action:@selector(moveRight) forControlEvents:UIControlEventTouchUpInside];
    bool check = NO;
    check = [self checkBoxConflictRight];
    for(Box *currentB in self.blk.block){
        CGPoint p;
        p.x = currentB.box.center.x;
        if(p.x >= maxX - boxSide) {
            check = YES;
            break;
        }
    }
    if(!check){
        for(Box *currentB in self.blk.block){
            CGPoint p;
            p.x = currentB.box.center.x + boxSide;
            p.y = currentB.box.center.y;
            currentB.box.center = p;
        }
    }
    [self.rightBtn addTarget:self action:@selector(moveRight) forControlEvents:UIControlEventTouchUpInside];
}
// add boxs which 've just been on ground to matrix
- (void) addToMatrix: (Block*) bl {
    for(Box *b in bl.block){
    int c = b.box.frame.origin.x / boxSide;
    int r = b.box.frame.origin.y / boxSide;
    //NSLog(@"%d : %d", r, c);
    _bs[r][c] = b;
    }
}
// check row in matrix
- (void) checkRow {
    for(int x = 0; x < maxRow; x++){
        for(int y = 0; y < maxColumn; y++){
            if(_bs[x][y]== 0) break;
            if(y == maxColumn - 1){
                NSLog(@"%d", x);
                [self removeRow:x];
                [self moveAllPreviousBoxs:x];
                [self updateBoxs];
                self.s.score += 20;
                [self displayScore:self.s];
            }
        }
    }
}
- (void) removeRow: (int)j {
    for(int i = 0; i<maxColumn; i++){
        [_bs[j][i].box removeFromSuperview];
        _bs[j][i] = 0;
    }
}
- (void) moveAllPreviousBoxs: (int ) k {
    for(int i = 0; i<k; i++){
        for(int j = 0; j<maxColumn; j++){
            if(_bs[i][j] != 0){
                _bs[i][j].box.center = CGPointMake(_bs[i][j].box.center.x, _bs[i][j].box.center.y + boxSide);
            }
        }
    }
    // update board
    for(int i = k; i>0; i--){
        for(int j = 0; j<maxColumn; j++){
            _bs[i][j] = _bs[i-1][j];
        }
    }
}
- (void) updateBoxs {
    [self.boxs removeAllObjects];
    for(int x = 0; x < maxRow; x++){
        for(int y = 0; y < maxColumn; y++){
            if(_bs[x][y] != 0)
                [self.boxs addObject:_bs[x][y]];
        }
    }
}
- (void) fastDown {
    [timer1 invalidate];
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveDown) userInfo:nil repeats:YES];
}
// check game over
- (void) checkGameOver {
    bool check = NO;
    for(int i = 0; i<2; i++){
        for(int j = 0; j<maxColumn; j++){
            if(_bs[i][j]!=0){
                check = YES;
                break;
            }
        }
    }
    
    if(check){
        EndGameView *endGameView = [[EndGameView alloc] initWithNibName:nil bundle:NULL];
        [self presentViewController:endGameView animated:YES completion:^{
            [self removeFromParentViewController];
        }];
    }
}
// after this view was disappeared , we need stop something
- (void) viewDidDisappear:(BOOL)animated {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [timer1 invalidate];
    timer1 = nil;
}
- (void) displayScore: (Score *) s {
    self.scoreLb.text = [NSString stringWithFormat:@"Score: %d", s.score];
}
@end
