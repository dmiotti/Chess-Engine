//
//  Board.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

public typealias GameBoard = [Tile]

open class Board: CustomStringConvertible {
    open let gameBoard: GameBoard
    open let nextMoveMaker: Piece.Alliance
    open let whitePieces: [Piece]
    open let blackPieces: [Piece]

    private init(builder: Builder) {
        gameBoard = Board.createGameBoard(builder: builder)
        nextMoveMaker = builder.nextMoveMaker
        whitePieces = Board.calculateActivePieces(on: gameBoard, for: .white)
        blackPieces = Board.calculateActivePieces(on: gameBoard, for: .black)

        let whiteStandardLegalMoves = calculateLegalMoves(pieces: whitePieces)
        let blackStandardLegalMoves = calculateLegalMoves(pieces: blackPieces)
    }

    public var description: String {
        var board = String()
        (0..<BoardUtils.numberOfTiles).forEach {
            let tileText = prettyPrint(tile: gameBoard[$0])
            board.append(tileText)
            if ((i + 1) % BoardUtils.numberOfTilesPerRow) == 0 {
                board.append("\n")
            }
        }
        return board
    }

    private func prettyPrint(tile: Tile) -> String {
        if let piece = tile.piece {
            if piece.alliance.isWhite {
                return tile.description.uppercased()
            }
            return tile.description.lowercased()
        }
        return ""
    }

    private static func createGameBoard(builder: Builder) -> GameBoard {
        var tiles = [Tile]()
        (0..<BoardUtils.numberOfTiles).forEach {
            tiles[$0] = Tile.createTile(coordinate: $0, piece: builder.config[$0])
        }
        return tiles
    }

    private static func calculateActivePieces(on gameBoard: GameBoard, for alliance: Piece.Alliance) -> [Piece] {
        return gameBoard.flatMap { $0.piece }.filter { $0.alliance == alliance }
    }

    private func calculateLegalMoves(pieces: [Piece]) -> [Move] {
        return pieces.flatMap { $0.calculateLegalMoves(board: self) }
    }

    private static func createStandardBoard() -> Board {
        let builder = Builder()

        builder.setPiece(Rook(position: 0, alliance: .black))
            .setPiece(Knight(position: 1, alliance: .black))
            .setPiece(Bishop(position: 2, alliance: .black))
            .setPiece(Queen(position: 3, alliance: .black))
            .setPiece(King(position: 4, alliance: .black))
            .setPiece(Bishop(position: 5, alliance: .black))
            .setPiece(Knight(position: 6, alliance: .black))
            .setPiece(Rook(position: 7, alliance: .black))

            .setPiece(Pawn(position: 8, alliance: .black))
            .setPiece(Pawn(position: 9, alliance: .black))
            .setPiece(Pawn(position: 10, alliance: .black))
            .setPiece(Pawn(position: 11, alliance: .black))
            .setPiece(Pawn(position: 12, alliance: .black))
            .setPiece(Pawn(position: 13, alliance: .black))
            .setPiece(Pawn(position: 14, alliance: .black))
            .setPiece(Pawn(position: 15, alliance: .black))

            .setPiece(Pawn(position: 48, alliance: .white))
            .setPiece(Pawn(position: 49, alliance: .white))
            .setPiece(Pawn(position: 50, alliance: .white))
            .setPiece(Pawn(position: 51, alliance: .white))
            .setPiece(Pawn(position: 52, alliance: .white))
            .setPiece(Pawn(position: 53, alliance: .white))
            .setPiece(Pawn(position: 54, alliance: .white))
            .setPiece(Pawn(position: 55, alliance: .white))

            .setPiece(Rook(position: 56, alliance: .white))
            .setPiece(Knight(position: 57, alliance: .white))
            .setPiece(Bishop(position: 58, alliance: .white))
            .setPiece(Queen(position: 59, alliance: .white))
            .setPiece(King(position: 60, alliance: .white))
            .setPiece(Bishop(position: 61, alliance: .white))
            .setPiece(Knight(position: 62, alliance: .white))
            .setPiece(Rook(position: 63, alliance: .white))

            .setMoveMaker(.white)

        return builder.build()
    }

    subscript(coordinate: Coordinate) -> Tile {
        get {
            return gameBoard[coordinate]
        }
    }

    open class Builder {
        var config = [Int: Piece]()
        var nextMoveMaker = Piece.Alliance.white

        @discardableResult public func setPiece(_ piece: Piece) -> Builder {
            config[piece.position] = piece
            return self
        }

        @discardableResult public func setMoveMaker(_ nextMoveMaker: Piece.Alliance) -> Builder {
            self.nextMoveMaker = nextMoveMaker
            return self
        }

        public func build() -> Board {
            return Board(builder: self)
        }
    }
}
