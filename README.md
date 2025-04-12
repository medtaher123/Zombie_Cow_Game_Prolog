# Zombie Cows Game

<p align="center">
  <img src="https://www.swi-prolog.org/download/logo/swipl-128.png" alt="Prolog Logo" width="100"/>
</p>

This project is a simple video game written in Prolog. The game involves a character, Dimitri, who gets lost in a pasture full of cows. As the night falls, one of the cows mysteriously dies and comes back to life as a zombie. The player controls Dimitri, trying to escape the herd without getting bitten by a zombie cow.


## Game Overview 

 
- **Objective** : Dimitri must escape the herd of cows without being bitten by a zombie cow.
 
- **Gameplay** : The game takes place on a rectangular board. The board contains rocks, trees, and cows of different races. As the game progresses, some cows turn into zombies, and the player must avoid them while trying to move Dimitri to safety.


## How to Try the Project

### 1. Clone the repository
Clone the project repository to your local machine using the following command:

```bash
git clone https://github.com/medtaher123/Zombie_Cow_Game_Prolog
```


### 2. Navigate to the project folder 


After cloning, go to the folder containing the project files:



```bash
cd Zombie_Cow_Game_Prolog
```


### 3. Execute the project in SWI-Prolog 


Run the SWI-Prolog interpreter by executing:



```bash
swipl -s main.pl
```


### 4. Start the game 


Once SWI-Prolog is loaded, start the game by typing the following command in the Prolog environment:



```prolog
:- jeu.
```

### 5. Configuring the Project

You can adjust the number of rocks, trees, and cows, as well as the size of the board, in the config.pl file. This allows you to customize the difficulty of the game.

## Game Controls

- **Move Up**: `z.`  
- **Move Right**: `d.`  
- **Move Down**: `s.`  
- **Move Left**: `q.`  
- **Stay in Place**: `a.`

These controls are configurable and can be adjusted in the configuration file to suit your preferences.









