//
//  Box.h
//  Buoi9- BVN- Tetris
//
//  Created by doductrung on 6/1/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Box : NSObject
@property (strong, nonatomic) UIImageView *box;
- (id) initWithColor: (NSString *) color ;
@end
