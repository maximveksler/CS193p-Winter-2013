//
//  CardGameViewController.m
//  Carder
//
//  Created by Maxim Veksler on 9/19/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *playingDeck;
@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    // Alter the selected state of the view, while in unselected display
    if(!sender.isSelected){
        [sender setTitle:[[self.playingDeck drawRandomCard] contents] forState:UIControlStateSelected];
    }
    
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

- (PlayingCardDeck *) playingDeck {
    if(!_playingDeck) _playingDeck = [[PlayingCardDeck alloc] init];
    return _playingDeck;
}
@end
