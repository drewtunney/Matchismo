//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Drew Tunney on 4/22/14.
//  Copyright (c) 2014 drewtunney. All rights reserved.
//

#import "CardMatchingGame.h"

// redeclaring the method CardMatchingGame in private
@interface CardMatchingGame()
// we redefine to readwrite. usually we don't need to include it because it's the default, but here we do since we declared it in the public API as readonly
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
{
    self = [super init];
    
    if (self){
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

// set constant
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    // if the card is not already matched
    if (!card.isMatched) {
        if (card.isChosen){
            card.chosen = NO;
        }
        else {
            // match against another card
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    // protecting against a bad index
    return (index < [self.cards count]) ? self.cards[index] :nil;
}

- (instancetype)init
{
    return nil;
}

@end
