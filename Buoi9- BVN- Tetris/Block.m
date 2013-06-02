//
//  Block.m
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/1/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "Block.h"
#import "config.h"
@implementation Block

- (id) initWithColor: (NSString *) color{
    self = [super init];
    self.block = [[NSMutableArray alloc] init];
    for(int i=0; i<4; i++){
        Box *b = [[Box alloc] initWithColor:color];
        [self.block addObject:b];
    }
    self.stuck = NO;
    return self;
}
- (void) createShape : (int) type andAt: (float)y : (float) x{
    int index = 0;
    CGPoint p = CGPointMake(x, y);
    for(Box *currentB in self.block){
        switch (type) {
            case 0: // chu i dung
                if(index == 0){
                    p.y = y;
                    p.x = x;
                }else
                {   p.y = index * boxSide + y;
                    p.x = x;
                    
                }
                self.style = @"I";
                self.status = 0;
                break;
            case 1: // chu i ngang
                if(index == 0) {
                    p.y = y;
                    p.x = x;
                }else {
                    p.x = index * boxSide + x;
                    p.y = y;
                }
                self.style = @"I";
                self.status = 1;
                break;
            case 2: // chu 0
                if(index == 0 || index == 1) {
                    p.y = y;
                    p.x = x + index * boxSide;
                }else {
                    p.x = x + (index - 2) * boxSide;
                    p.y = y + boxSide;
                }
                self.style = @"O";
                self.status = 0;
                break;
            case 3: // chu l
                if(index == 0 || index == 1 || index == 2) {
                    p.x = x;
                    p.y = y + index * boxSide;
                }else {
                    p.y = y + (index - 1) * boxSide;
                    p.x = x + boxSide;
                }
                self.style = @"L";
                self.status = 0;
                break;
            case 4: // chu l xoay phai
                if(index == 0 || index == 1 || index == 2) {
                    p.y = y;
                    p.x = x + index * boxSide;
                }else {
                    p.x = x + (index - 3) * boxSide;
                    p.y = y + boxSide;
                }
                self.style = @"L";
                self.status = 1;
                break;
            case 5: // chu l xoay phai 2 lan
                if(index == 0 || index == 1 || index == 2) {
                    p.x = x;
                    p.y = y + index * boxSide;
                }else {
                    p.y = y + (index - 3) * boxSide;
                    p.x = x - boxSide;
                }
                self.style = @"L";
                self.status = 2;
                break;
                
            case 6: // chu l xoay phai 3 lan
                if(index == 0 || index == 1 || index == 2) {
                    p.y = y;
                    p.x = x + index * boxSide;
                }else {
                    p.x = x + (index - 1) * boxSide;
                    p.y = y - boxSide;
                }
                self.style = @"L";
                self.status = 3;
                break;
            case 7: // chu t
                if(index == 0 || index == 1 || index == 2){
                    p.x = x + index * boxSide;
                    p.y = y;
                }else{
                    p.y = y + boxSide;
                    p.x = x + (index - 2) * boxSide;
                }
                self.style = @"T";
                self.status = 3;
                break;
            case 8: // chu t dx Ox
                if(index == 0 || index == 1 || index == 2){
                    p.x = x + index * boxSide;
                    p.y = y;
                }else{
                    p.y = y - boxSide;
                    p.x = x + (index - 2) * boxSide;
                }
                self.style = @"T";
                self.status = 0;
                break;
            case 9: // chu t xoay phai
                if(index == 0 || index == 1 || index == 2){
                    p.y = y + index * boxSide;
                    p.x = x;
                }else{
                    p.x = x + boxSide;
                    p.y = y + (index - 2) * boxSide;
                }
                self.style = @"T";
                self.status = 1;
                break;
            case 10: // chu t xoay phai va dx Oy
                if(index == 0 || index == 1 || index == 2){
                    p.y = y + index * boxSide;
                    p.x = x;
                }else{
                    p.x = x - boxSide;
                    p.y = y + (index - 2) * boxSide;
                }
                self.style = @"T";
                self.status = 2;
                break;
            case 11: // chu z
                if(index == 0 || index == 1){
                    p.x = x + index * boxSide;
                    p.y = y;
                }else{
                    p.x = x + (index - 1) * boxSide;
                    p.y = y + boxSide;
                }
                self.style = @"Z";
                self.status = 0;
                break;
            case 12: // chu z xoay phai
                if(index == 0 || index == 1){
                    p.y = y + index * boxSide;
                    p.x = x;
                }else{
                    p.y = y + (index - 1) * boxSide;
                    p.x = x - boxSide;
                }
                self.style = @"Z";
                self.status = 1;
                break;
                
            default:
                break;
        }
        currentB.box.center = p;
        index ++;
    }
}
- (void) addViewTo: (UIView *) view {
    for(Box *currentB in self.block){
        [view addSubview:currentB.box];
    }
}
- (void) changeShapeTo: (int) i{
    Box *firstB = [self.block objectAtIndex:0];
    float y = firstB.box.center.y;
    float x = firstB.box.center.x;
    [self createShape:i andAt:y : x];
}
- (void) moveLeft: (int) i {
    for(Box *b in self.block){
        b.box.center = CGPointMake(b.box.center.x - i, b.box.center.y);
    }
}
- (void) moveRight: (int) i {
    for(Box *b in self.block){
        b.box.center = CGPointMake(b.box.center.x + i, b.box.center.y);
    }
}
@end
