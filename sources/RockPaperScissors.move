address 0x9118a39d5e98bb262c79238a99e4469457db8c9f71cc29907033885377a6975e {

module RockPaperScissorsV2 {
    use std::signer;
    
    const ROCK: u8 = 1;
    const PAPER: u8 = 2;
    const SCISSORS: u8 = 3;

    struct Game has key {
        player1: address,
        player2: address,
        player1_move: u8,
        player2_move: u8,
        result: u8,
        player1_score: u64,
        player2_score: u64,
    }

    public entry fun start_game(account1: &signer, account2: address) {
        let player1 = signer::address_of(account1);

        let game = Game {
            player1,
            player2: account2,
            player1_move: 0,
            player2_move: 0,
            result: 0,
            player1_score: 0,
            player2_score: 0,
        };

        move_to(account1, game);
    }

    public entry fun set_player1_move(account1: &signer, player1_move: u8) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account1));
        game.player1_move = player1_move;
    }

    public entry fun set_player2_move(account1: &signer, player2_move: u8) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account1));
        assert!(signer::address_of(account1) == game.player1, 0);
        game.player2_move = player2_move;
    }

    public entry fun finalize_game_results(account1: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account1));
        assert!(game.player1_move != 0 && game.player2_move != 0, 1);
        
        let result = determine_winner(game.player1_move, game.player2_move);
        game.result = result;

        if (result == 2) {
            game.player1_score = game.player1_score + 1; // Player 1 wins
        } else if (result == 3) {
            game.player2_score = game.player2_score + 1; // Player 2 wins
        }
    }

    fun determine_winner(player1_move: u8, player2_move: u8): u8 {
        if (player1_move == ROCK && player2_move == SCISSORS) {
            2 // player1 wins
        } else if (player1_move == PAPER && player2_move == ROCK) {
            2 // player1 wins
        } else if (player1_move == SCISSORS && player2_move == PAPER) {
            2 // player1 wins
        } else if (player1_move == player2_move) {
            1 // draw
        } else {
            3 // player2 wins
        }
    }

    public entry fun restart_game(account1: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account1));
        game.player1_move = 0;
        game.player2_move = 0;
        game.result = 0;
    }

    #[view]
    public fun get_player1_move(account1_addr: address): u8 acquires Game {
        borrow_global<Game>(account1_addr).player1_move
    }

    #[view]
    public fun get_player2_move(account1_addr: address): u8 acquires Game {
        borrow_global<Game>(account1_addr).player2_move
    }

    #[view]
    public fun get_game_results(account1_addr: address): u8 acquires Game {
        borrow_global<Game>(account1_addr).result
    }

    #[view]
    public fun get_player1_score(account1_addr: address): u64 acquires Game {
        borrow_global<Game>(account1_addr).player1_score
    }

    #[view]
    public fun get_player2_score(account1_addr: address): u64 acquires Game {
        borrow_global<Game>(account1_addr).player2_score
    }
}
}