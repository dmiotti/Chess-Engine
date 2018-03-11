//
//  Player.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

/// Represent a chess player
open class Player {
    public let board: Board
    public let king: King
    public let legalMoves: [Move]
    public let opponentMoves: [Move]
    public let alliance: Piece.Alliance
    public let isInCheck: Bool

    init(board: Board, alliance: Piece.Alliance, legalMoves: [Move], opponentMoves: [Move]) {
        self.board = board
        self.legalMoves = legalMoves
        self.opponentMoves = opponentMoves
        self.alliance = alliance
        if alliance == .white {
            self.king = board.whitePieces.first { $0 is King } as! King
        } else {
            self.king = board.blackPieces.first { $0 is King } as! King
        }
        self.isInCheck = !Player.calculateAttacksOnTile(position: king.position, opponentMoves: opponentMoves).isEmpty
    }

    /// Get the opponent player
    public var opponent: Player {
        switch alliance {
        case .black:
            return board.whitePlayer
        case .white:
            return board.blackPlayer
        }
    }

    /// Check if the move provided is a legal move
    ///
    /// - Parameter move: The move to check
    /// - Returns: `true` if the move is valid. `false` otherwise.
    public func isLegal(move: Move) -> Bool {
        return legalMoves.contains(move)
    }

    /// Returns true if the player is in checkmate
    public var isInCheckMate: Bool {
        return isInCheck && !hasEscapeMoves()
    }

    /// Returns true if the player is in stalemate
    public var isInStaleMate: Bool {
        return !isInCheck && !hasEscapeMoves()
    }

    /// Make a move in board
    ///
    /// - Parameter move: The move to make
    /// - Returns: A move transition
    private func makeMove(_ move: Move) -> MoveTransition {
        if !isLegal(move: move) {
            return MoveTransition(board: board, move: move, moveStatus: .illegalMove)
        }

        let transitionBoard = move.execute()

        let kingAttacks = Player.calculateAttacksOnTile(
            position: transitionBoard.currentPlayer.opponent.king.position,
            opponentMoves: transitionBoard.currentPlayer.legalMoves)

        if !kingAttacks.isEmpty {
            return MoveTransition(board: board, move: move, moveStatus: .leavesPlayerInCheck)
        }

        return MoveTransition(board: transitionBoard, move: move, moveStatus: .done)
    }

    /// Check if the player has escape moves
    ///
    /// - Returns: `true` if the player can make a move. `false` otherwise.
    private func hasEscapeMoves() -> Bool {
        for move in legalMoves {
            let transition = makeMove(move)
            if transition.moveStatus == .done {
                return true
            }
        }
        return false
    }

    /// Get all moves that attack a particular tile
    ///
    /// - Parameters:
    ///   - position: The position to check
    ///   - opponentMoves: Opponents moves
    /// - Returns: Move that attack the provided position on the board
    private static func calculateAttacksOnTile(position: Coordinate, opponentMoves: [Move]) -> [Move] {
        return opponentMoves.filter { $0.destinationCoordinate == position }
    }
}
