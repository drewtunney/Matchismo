//
//  CardGameViewController.m
//  Machismo
//
//  Created by Drew Tunney on 4/21/14.
//  Copyright (c) 2014 drewtunney. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
// add the deck property, it's strong because we need it to stay around, we are going to call the Deck property deck
@property (strong, nonatomic) Deck *deck;

// create a property that holds our CardMatchingGame
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}


// we are giving ourself access to the playing card deck in this controler?



- (Deck *)createDeck
{
    // lazy instantation
    return [[PlayingCardDeck alloc] init];
}



- (IBAction)touchCardButton:(UIButton *)sender
{
    // where sending button is in the array
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        // now we get the card button
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        // now we ask our model for the card at that index
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        // button enabled only when card is not matched
        cardButton.enabled = !card.isMatched;
    }
    // %d is a basically erb?
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen? @"frontcard" : @"cardback"];
}

@end
