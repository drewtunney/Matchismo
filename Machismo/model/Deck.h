//
//  Deck.h
//  Machismo
//
//  Created by Drew Tunney on 4/21/14.
//  Copyright (c) 2014 drewtunney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
