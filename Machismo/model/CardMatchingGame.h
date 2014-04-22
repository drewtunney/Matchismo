//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Drew Tunney on 4/22/14.
//  Copyright (c) 2014 drewtunney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// give a crack at the public API first
// how are people going to use this class?

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
// we're now using deck, we need to import the class

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

// using NSInteger here because it could also be negative
@property (nonatomic, readonly) NSInteger score;

@end
