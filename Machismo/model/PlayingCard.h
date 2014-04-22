//
//  PlayingCard.h
//  Machismo
//
//  Created by Drew Tunney on 4/21/14.
//  Copyright (c) 2014 drewtunney. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray*)validSuits;
+ (NSUInteger)maxRank;

@end
