//
//  Block.h
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/1/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box.h"
@interface Block : NSObject
@property (nonatomic, strong) NSMutableArray *block;
// style: i, o, l, t, z
@property (nonatomic, strong)  NSString *style;
// status: 0,1 or 0,1,2,3
@property (nonatomic, assign) bool stuck;
@property (nonatomic, assign)  int status;
- (void) createShape: (int) type andAt: (float)y : (float) x;
- (void) addViewTo: (UIView *) view;
- (void) changeShapeTo: (int) i;
- (void) moveLeft: (int) i;
- (void) moveRight: (int) i;
- (id) initWithColor: (NSString *) color;
@end
