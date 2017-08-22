# Greement

## Goal of the game

Be the richest player when the turn count is up (decided before the game starts) . The total wealth of the player is the sum of the value of all his 
properties, plus his money.


## What you’ll need

- One Pen and paper for each player and one for the values table
- 60 brown squares. The lands
- 60 green squares. The crops
- 30 yellow squares. The gold mines
- 5 blue squares. Lakes
- 5 gray squares. Mountains
- Something to mark the ownership of a square, ie: beans

## Starting the game

Put all squares, except the green ones (crops), on the table facing down on a 10x10 grid.   
Each player must choose a square to be his starting square. The square must not be connected to any other 
player starting square.  
If the player chooses a mountain, a lake or a gold mine he must choose another square.  
The tile is converted to a crop right after the player chooses it.  

After all players have chosen their starting squares, turn all squares up.

The table of values must be visible to all players, and will contain:
- The land price
- The seed price - An unseeded land doesn’t make profit
- The seeded land profit - a crop
- The gold mine price
- The gold mine profit 
- The distance tax - that is the tax when you buy any land. The tax is cumulative, so a land that 
is 2 squares of distance (manhattan distance) from your land costs the normal price plus distance minus one times tax. ie: 
if the tax is 1c and X is your land:

|3|2|3|  
|2|0|2|  
|0|X|0|  
|2|0|2|  
|3|2|3|  

The tax is also applied on player to player (p2p) payments. If a player has no lands he doesn't need to pay p2p taxes.  
- The lake multiplier - All lands connected to a lake (vertically or horizontally, diagnals don't count) 
will have its value and profit multiplied by this factor - multipliers are cumulative, 
if a land is connected to two lakes and the multiplier is 2x, the land will have a 4x multiplier
- The mountain multiplier - All lands connected to a mountain (vertically or horizontally, diagonals 
don't count) will have its value and profit multiplied by this factor - multipliers are 
cumulative even between lakes and mountains
- The loan multiplier - This is the value multiplied to your debt at the end of your play.

Also, must be visible to all players:
- The shuffled “Events” deck
- The shuffled “Paid actions” deck

No value can go below one.

|Land price ($)|Seed price ($)|Crop profit ($)|Gold mine ($)|Gold mine profit ($)|Lake multiplier (x)|Mountain multiplier (x)|Distance tax(per square) ($)|Cattle price ($)|Cattle profit ($)|Action card ($)|
|--------------|--------------|---------------|-------------|--------------------|-------------------|-------------------------|----------------------------|----------------|-----------------|---------------|
|2             |2             |4              |6            |6                   |1                  |1                      |6                           |8               |8                |15             |

## A players turn

The first thing is to collect the profit. This must be done before any 
other action. The subsequent
actions can be performed in any order.
The profit for each square is the value from the value table. 
After collecting the profit the player can:

**Buy/sell land** - Note that the player must pay the distance tax. 
On a player to player negotiation, who pays the tax is up to the players to decide. An empty land costs 
the price on the value table, 
but an owned land can be sold at any price the owner wishes. For example, a player may charge a higher 
price for a land with a double profit multiplier.  

**Seed a land** - Brown squares are unseeded land, to make a profit the player must seed his land, turning 
it on a crop. When a land is seeded a green square replaces the brown one.  

**Buy cattle** - A player can convert a crop square on a cattle square by buying cattle. The square ceases to 
be a crop, its profit is now the value in the “Cattle profit” on the value table.  

**Player to player payment** - A player owns his money, and can use it the way he chooses, including giving it to other 
players to gain political support. Any payments must inlucde the 
distance tax, being the distance the smaller distance between any of the players squares. The tax goes to the bank. A player with no lands doesn't pay donation taxes to donate or receive money. Note that it’s a donation, so if the other accepts the payment this doesn’t mean he will respect the agreement.  

**Buy action card** - A player can buy and use an action card, he can buy and use as many cards as he wants, 
limited by the deck size.  the action card returns to the deck and it is reshuffled.

## Events

Every time is the first player turn (except the first time), three event cards are drawn from the 
events deck, facing down. The first card is then turned up, 
read and after all players took action the event is triggered or not. Then the next event card is turned 
up and so on until all events are done.  
The event cards return to the deck and it is reshufled. The turn count is bumped. If the turn count reached the limit, the game ends.

There are two types of event, the “vote to avoid” and the “pay to avoid”.

- **Vote to avoid** - If the majority of the players vote against this event, it will not be triggered. On the 
voting phase, the player can donate money to another 
player to change his vote, obeying the distance tax. In case of draw the event is triggered. After the 
voting the event is triggered immediately.
- **Pay to avoid** - If the value of this event is paid, it will not be triggered. Each event have different payment rules.

The events:

### Vote to avoid:
- Increase lake multiplier, Decrease mountain multiplier - 1 cards
- Increase mountain multiplier, Decrease lake multiplier  - 1 cards
- Increase lake multiplier and mountain, Decrease gold mine profit by 2 - 1 cards
- Increase land price, Decrease gold mine price - 2 card
- Decrease land price, Increase gold mine price - 1 cards
- Increase cattle price, Increase cattle profit - 1 cards
- Decrease cattle price, Decrease cattle profit - 1 cards
- Increase seed price, Increase crop profit - 1 cards
- Decrease seed price, Decrease crop profit - 1 cards
- Increase crop profit, Decrease gold mine profit- 1 card
- Decrease crop profit, Increase gold mine profit - 2 cards
- Increase cattle profit, Decrease gold mine profit- 1 card
- Decrease cattle profit, Increase gold mine profit - 2 cards
- Increase crop profit, Decrease cattle profit- 1 card
- Decrease crop profit, Increase cattle profit - 1 cards
- Decrease distance tax by two, Decrease crop profit - 4 cards
- Decrease distance tax by two, Increase gold mine profit 2c - 5 cards
- All gold mines are lost (back to no owner) - 2 cards
- All crops are lost (become unseeded land), gold mine profit increases 3c - 5 cards
- All cattle convert to crops , gold mine profit increases 3c - 3 cards
- All gold mines are lost, all lands are converted to cattle - 2 cards
- Decrease Gold profit - 2 cards
- Increase Gold profit - 5 cards
- Decrease distance tax, Decrease lake and mountain multiplier - 5  cards
- Decrease Action card price by 2 - 5 cards

### Pay to avoid:
- Cattle disease, each player must pay 2c for each of his own squares with cattle. All unpaid squares are 
converted back to crops but are still owned by the player. - Pay 20c to avoid this. - 3 cards
- Government appropriation Lake - All lands connected to a lake will be taken from the owner, the owner 
will receive 2c per square taken. - Pay 15c to avoid this - 3 cards
- Government appropriation Mountain - All lands connected to a lake will be taken from the owner, the 
owner will receive 1c per square taken - Pay 10c to avoid this - 2 cards
- Government appropriation Gold Mines - All Gold Mines will be taken from the owner, the 
owner will receive 1c per Gold Mine taken - Pay 50c to avoid this - 2 cards

### Action cards
- Steal any 2 territories (including lands with no owner) - 1 card
- Decide next vote - 3 cards
- Increase any value by 2 - 1 card
- Decrease any value by 2 - 1 card
- Receive from any player two times the value of the current distance tax

The game proceeds until the turn count reaches a given number (20 for example, decided before game begun), then the player with the biggest wealth, or the smallest debt, wins!
