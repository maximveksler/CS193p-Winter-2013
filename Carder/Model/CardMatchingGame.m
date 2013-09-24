//
//  CardMatchingGame.m
//  Carder
//
//  Created by Maxim Veksler on 9/21/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame() 
@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card 
@end

@implementation CardMatchingGame

-(NSMutableArray *) cards {
    if (! _cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_BONUS 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)inedx {
    Card *card = [self cardAtIndex:inedx];
    
    // If we were able to pull a card from the deck (valid index)
    // and the card is playble (hasn't been matched yet)
    if(card && !card.isUnplayble) {
        // Only do matching if the card is showing the backside of itself.
        if(!card.isFaceUp) {
            // We look for other cards, aiming to future find potential match
            for(Card *otherCard in self.cards) {
                // We check each card to see if it's also faceUp & is playble.
                if(otherCard.isFaceUp && !otherCard.isUnplayble) {
                    /*
                     We found 2 cards who are faceUp. Means user in match request
                     state. Lets try to match them and see what happens.
                    */
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore) {
                        // If both cards matched, set them both unplayble for future matches.
                        card.unplayble = YES;
                        otherCard.unplayble = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        // otherwise, if the cards don't match: Set the other card status to not flipped
                        // and implement a fine on the user for not obeying the rules !
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_BONUS;
                    }
                    break;
                }
            }
            
            // We take penaltiy each time you flip a card (we are assholes!).
            self.score -= FLIP_COST;
        }
        
        // Finally we flip our starting card state.
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }

        }
    }
    
    return self;
}
@end
