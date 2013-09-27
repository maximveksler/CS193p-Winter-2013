//
//  CardGameViewController.m
//  Carder
//
//  Created by Maxim Veksler on 9/19/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *) _xGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count ] usingDeck:[[PlayingCardDeck alloc] init]];
}

@synthesize game = _game;

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [self _xGame];
    }
    return _game;
}

- (void) setGame:(CardMatchingGame *)game {
    _game = game;
}

- (IBAction)deal {
    self.game = [self _xGame];
    self.flipCount = 0;
    [self updateUI];
}

- (void)setCardButtons:(NSArray *)cardButtons {
    NSLog(@"Once");
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayble;
        cardButton.alpha = card.isUnplayble ? 0.3 : 1.0;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastMoveLabel.text = self.game.lastMove;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}


@end
