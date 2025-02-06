# RockPaperScissorsV2 Move Module

## Overview
The `RockPaperScissorsV2` module is an upgraded version of the classic Rock-Paper-Scissors game implemented in the Move programming language. This version introduces several new features to enhance gameplay, including endless gameplay, scorekeeping, and a Player vs. Player mode.

## Features

### 1. Endless Gameplay
The module supports endless gameplay, allowing players to continuously play without the need to restart the module. After each game round, players can simply reset the game state and start a new round, while maintaining their current scores.

- **Functionality:**
  - `restart_game(account: &signer)`:
    - Resets the game state (player moves and result) to start a new round.
    - Scores are preserved across rounds.

### 2. Keeping Score
To add a competitive element, the module now keeps track of the scores for both players. Scores are automatically updated after each round, depending on who wins.

- **Functionality:**
  - `get_player1_score(account1_addr: address): u64`:
    - Retrieves the current score of Player 1.
  - `get_player2_score(account1_addr: address): u64`:
    - Retrieves the current score of Player 2.
  - **Scoring Logic:**
    - If Player 1 wins a round, their score is incremented by 1.
    - If Player 2 wins a round, their score is incremented by 1.
    - Scores persist across multiple rounds of gameplay.

### 3. Player vs. Player Mode
In addition to playing against a computer, this module now supports a Player vs. Player mode. Two players can compete against each other in real-time, with both their moves and scores tracked separately.

- **Functionality:**
  - `start_game(account1: &signer, account2: address)`:
    - Initializes a new game with two players, setting both players' addresses and starting their scores at 0.
  - `set_player1_move(account1: &signer, player1_move: u8)`:
    - Sets the move for Player 1.
  - `set_player2_move(account1: &signer, player2_move: u8)`:
    - Sets the move for Player 2.
  - `finalize_game_results(account1: &signer)`:
    - Determines the winner of the round based on the moves of both players and updates their scores accordingly.
  
## How to Use

1. **Start a New Game**:
   - Use `start_game(account1: &signer, account2: address)` to begin a new game between two players.

2. **Set Moves**:
   - Player 1 sets their move with `set_player1_move(account1: &signer, player1_move: u8)`.
   - Player 2 sets their move with `set_player2_move(account1: &signer, player2_move: u8)`.

3. **Finalize Results**:
   - Call `finalize_game_results(account1: &signer)` to determine the winner and update the scores.

4. **Restart the Game**:
   - Use `restart_game(account: &signer)` to reset the moves and start a new round while keeping the current scores.

5. **Check Scores**:
   - Retrieve the current score of Player 1 using `get_player1_score(account1_addr: address)`.
   - Retrieve the current score of Player 2 using `get_player2_score(account1_addr: address)`.

## Example Workflow

```move
// Initialize a new game
start_game(&account1, account2);

// Player 1 sets their move
set_player1_move(&account1, ROCK);

// Player 2 sets their move
set_player2_move(&account1, PAPER);

// Finalize the round and update scores
finalize_game_results(&account1);

// Check scores
get_player1_score(account1);
get_player2_score(account2);

// Restart the game for a new round
restart_game(&account1);
