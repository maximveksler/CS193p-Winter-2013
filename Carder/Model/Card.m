//
//  Card.m
//  Carder
//
//  Created by Maxim Veksler on 9/19/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import "Card.h"


@implementation Card
-(int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]) {
            return 1;
        }
    }
    return score;
}
@end
