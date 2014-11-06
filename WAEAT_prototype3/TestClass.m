//
//  NSObject+TestClass.m
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 10. 31..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass : NSObject 

- (id)init {
    self = [super init];
    if(self) {
        NSLog(@"Hello world");
    }
    return self;
}

- (void)sayHello {
    NSLog(@"Hello swift, I'm objective c");
}

@end
