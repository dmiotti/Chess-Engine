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
    public let isInCheckMate: Bool
    public let isInStaleMate: Bool
    public let isCastled: Bool

    init(board: Board, alliance: Piece.Alliance, legalMoves: [Move], opponentMoves: [Move]) {
        self.board = board
        self.legalMoves = legalMoves
        self.opponentMoves = opponentMoves
        self.alliance = alliance
        self.king = board.blackPieces.first { $0 is King } as! King
        let isInCheck = !Player.calculateAttacksOnTile(position: king.position, opponentMoves: opponentMoves).isEmpty
        self.isInCheck = isInCheck
        let isInStaleMate = legalMoves.filter { $0.piece is King }.count == 0
        self.isInStaleMate = isInStaleMate && !isInCheck
        self.isInCheckMate = isInCheck && isInStaleMate
        self.isCastled = false
    }

    public var opponent: Player {
        switch alliance {
        case .black:
            return board.whitePlayer
        case .white:
            return board.blackPlayer
        }
    }

    public func isLegal(move: Move) -> Bool {
        return legalMoves.contains(move)
    }

    private static func calculateAttacksOnTile(position: Coordinate, opponentMoves: [Move]) -> [Move] {
        return opponentMoves.filter { $0.destinationCoordinate == position }
    }
}
