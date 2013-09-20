//
//  Card.h
//  Carder
//
//  Created by Maxim Veksler on 9/19/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayble) BOOL unplayble;

- (int)match:(NSArray *)otherCards;
@end
