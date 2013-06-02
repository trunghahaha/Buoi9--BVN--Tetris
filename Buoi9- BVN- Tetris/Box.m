//
//  Box.m
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/1/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "Box.h"
#import "config.h"
@implementation Box


- (id) initWithColor: (NSString *) color {
    Box *b = [[Box alloc] init];
    b.box = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",color]]];
    b.box.frame = CGRectMake(0,0,boxSide,boxSide);
    b.box.tag = 1;
    return b;
}
@end
