//
//  Tile.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

public typealias Coordinate = Int

open class Tile: CustomStringConvertible {
    private static var emptyTilesCache: [Int: EmptyTile] = {
        var emptyTiles = [Int: EmptyTile]()
        (0..<BoardUtils.numberOfTiles).forEach {
            emptyTiles[$0] = EmptyTile(coordinate: $0)
        }
        return emptyTiles
    }()
    
    private let coordinate: Coordinate
    
    private init(coordinate: Coordinate) {
        self.coordinate = coordinate
    }

    public var description: String {
        return "Tile"
    }
    
    public static func createTile(coordinate: Coordinate, piece: Piece?) -> Tile {
        if let piece = piece {
            return OccupiedTile(coordinate: coordinate, piece: piece)
        }
        return emptyTilesCache[coordinate]!
    }
    
    open var isOccupied: Bool {
        fatalError("You must inherit from Tile class")
    }
    
    open var piece: Piece? {
        fatalError("You must inherit from Tile class")
    }
    
    final private class EmptyTile: Tile {
        override init(coordinate: Int) {
            super.init(coordinate: coordinate)
        }
        
        override public var isOccupied: Bool {
            return false
        }
        
        public override var piece: Piece? {
            return nil
        }

        override var description: String {
            return "-"
        }
    }
    
    final private class OccupiedTile: Tile {
        private let pieceOnTile: Piece
        
        public init(coordinate: Coordinate, piece: Piece) {
            self.pieceOnTile = piece
            super.init(coordinate: coordinate)
        }
        
        public override var isOccupied: Bool {
            return true
        }
        
        public override var piece: Piece? {
            return pieceOnTile
        }

        override var description: String {
            if pieceOnTile.alliance.isBack {
                return pieceOnTile.description.lowercased()
            }
            return pieceOnTile.description.uppercased()
        }
    }
}
