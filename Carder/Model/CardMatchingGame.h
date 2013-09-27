//
//  CardMatchingGame.h
//  Carder
//
//  Created by Maxim Veksler on 9/21/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject
// designated initializer
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)inedx;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) int score;
@property (nonatomic) NSString *lastMove;
@end
