//
//  CardMatchingGame.m
//  Carder
//
//  Created by Maxim Veksler on 9/21/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import "CardMatchingGame.h"

#define NSLOGBOOL(BOOL) BOOL ? @"YES" : @"NO"

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

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.lastMove = nil;
    
    // If we were able to pull a card from the deck (valid index)
    // and the card is playble (hasn't been matched yet)
    NSLog(@"flipCardAtIndex %d card %@", index, card.contents);
    if(card && !card.isUnplayble) {
        NSLog(@"flipCardAtIndex card %@ is playble", card.contents);
        // Only do matching if the card is showing the backside of itself.
        if(!card.isFaceUp) {
            // We take penaltiy each time you flip a card (we are assholes!).
            self.score -= FLIP_COST;
            self.lastMove = [NSString stringWithFormat:@"Flipped up %@", card.contents];

            NSLog(@"flipCardAtIndex card %@ is not faceUp. Cool.", card.contents);
            // We look for other cards, aiming to future find potential match
            for(Card *otherCard in self.cards) {
                // We check each card to see if it's also faceUp & is playble.
                if(otherCard.isFaceUp && !otherCard.isUnplayble) {
                    NSLog(@"flipCardAtIndex Matching against card %@", otherCard.contents);
                    /*
                     We found 2 cards who are faceUp. Means user in match request
                     state. Lets try to match them and see what happens.
                    */
                    int matchScore = [card match:@[otherCard]];
                    NSLog(@"flipCardAtIndex card %@ vs card %@ match score is %d", card.contents, otherCard.contents, matchScore);
                    if(matchScore) {
                        // If both cards matched, set them both unplayble for future matches.
                        card.unplayble = YES;
                        otherCard.unplayble = YES;
                        self.score += matchScore * MATCH_BONUS;
                        NSLog(@"flipCardAtIndex setting card %@ unplayble = YES", card.contents);
                        NSLog(@"flipCardAtIndex setting otherCard %@ unplayble = YES", otherCard.contents);
                        self.lastMove = [NSString stringWithFormat:@"%@ & %@ matched for %d points", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    } else {
                        // otherwise, if the cards don't match: Set the other card status to not flipped
                        // and implement a fine on the user for not obeying the rules !
                        NSLog(@"flipCardAtIndex setting otherCard %@ faceUp = NO", otherCard.contents);
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_BONUS;
                        self.lastMove = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty", card.contents, otherCard.contents, MISMATCH_BONUS];
                    }
                    break;
                }
            }
        }
        
        // Finally we flip our starting card state.
        NSLog(@"flipCardAtIndex setting card %@ faceUp = %@", card.contents, NSLOGBOOL(!card.isFaceUp));
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
