//
//  Deck.h
//  Carder
//
//  Created by Maxim Veksler on 9/19/13.
//  Copyright (c) 2013 Maxim Veksler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;
@end
