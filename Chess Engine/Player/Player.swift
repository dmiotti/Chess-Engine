//
//  Player.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

open class Player {
    let board: Board
    let king: King
    let legalMoves: [Move]
    let opponentMoves: [Move]
    let alliance: Piece.Alliance

    init(board: Board, alliance: Piece.Alliance, legalMoves: [Move], opponentMoves: [Move]) {
        self.board = board
        self.legalMoves = legalMoves
        self.opponentMoves = opponentMoves
        self.alliance = alliance
        self.king = board.blackPieces.first { $0 is King } as! King
    }

    var opponent: Player {
        switch alliance {
        case .black:
            return board.whitePlayer
        case .white:
            return board.blackPlayer
        }
    }

    func isLegal(move: Move) {

    }
}
