# Zombie Cows Game

<p align="center">
  <img src="https://www.swi-prolog.org/download/logo/swipl-128.png" alt="Prolog Logo" width="100"/>
</p>

This project is a simple video game written in Prolog. The game involves a character, Dimitri, who gets lost in a pasture full of cows. As the night falls, one of the cows mysteriously dies and comes back to life as a zombie. The player controls Dimitri, trying to escape the herd without getting bitten by a zombie cow.


## Game Overview 

 
- **Objective** : Dimitri must escape the herd of cows without being bitten by a zombie cow.
 
- **Gameplay** : The game takes place on a rectangular board. The board contains rocks, trees, and cows of different races. As the game progresses, some cows turn into zombies, and the player must avoid them while trying to move Dimitri to safety.


## How to Try the Project

### Option 1: Normal Execution with SWI-Prolog

If you have SWI-Prolog installed, you can follow these steps to run the game:

#### 1. Clone the repository
Clone the project repository to your local machine using the following command:

```bash
git clone https://github.com/medtaher123/Zombie_Cow_Game_Prolog
```


#### 2. Navigate to the project folder 


After cloning, go to the folder containing the project files:



```bash
cd Zombie_Cow_Game_Prolog
```


#### 3. Execute the project in SWI-Prolog 


Run the SWI-Prolog interpreter and start the game in one step:


```bash
swipl -s main.pl -g jeu
```
This will start the game directly in SWI-Prolog.




### Option 2: Easier Execution with Docker 


If you don't have SWI-Prolog installed or you want an easier way to run the game, you can use Docker. Docker simplifies the process by running the game in a container.


#### 1. Build and run the Docker container 


To build the Docker image and run the game, use the following commands:



```bash
# Build the Docker image
docker build -t zombie-cows-game .

# Run the Docker container interactively and remove it after execution
docker run -it --rm zombie-cows-game
```


This will build the Docker image and start the game in the terminal, where you can interact with it just like in SWI-Prolog.
### 5. Configuring the Project

You can adjust the number of rocks, trees, and cows, as well as the size of the board, in the config.pl file. This allows you to customize the difficulty of the game.

## Game Controls

- **Move Up**: `z.`  
- **Move Right**: `d.`  
- **Move Down**: `s.`  
- **Move Left**: `q.`  
- **Stay in Place**: `a.`

These controls are configurable and can be adjusted in the configuration file to suit your preferences.

# Feel Free to Fork and Contribute
Feel free to fork this project, make improvements, or open pull requests. Contributions are always welcome!









