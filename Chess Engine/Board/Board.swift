//
//  Board.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

open class Board {
    var tiles = [Tile]()

    subscript(coordinate: Coordinate) -> Tile {
        get {
            return tiles[coordinate]
        }
        set {
            tiles[coordinate] = newValue
        }
    }
}
