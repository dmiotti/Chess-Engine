//
//  BoardUtils.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

open class BoardUtils {
    static public let firstColumn = initColumn(0)
    static public let secondColumn = initColumn(1)
    static public let seventhColumn = initColumn(6)
    static public let eighthColumn = initColumn(7)
    
    static public let secondRow = initColumn(7)
    static public let seventhRow = initColumn(7)
    
    static public let numberOfTiles = 64
    static public let numberOfTilesPerRow = 8
    
    static private func initColumn(_ columnNumber: Int) -> [Bool] {
        var column = [Bool](repeating: false, count: numberOfTiles)
        var number = columnNumber
        repeat {
            column[number] = true
            number += numberOfTilesPerRow
        } while number < numberOfTiles
        return column
    }
    
    private init() {}
    
    open static func isValidTileCoordinate(_ coordinate: Coordinate) -> Bool {
        return coordinate >= 0 && coordinate < numberOfTiles
    }
}
