//
//  GameModel.swift
//  Swift2048
//
//  Created by mengdong on 14-6-30.
//  Copyright (c) 2014年 com.mengdong. All rights reserved.
//

import UIKit

class GameModel: NSObject {
   
    //方块行数和列数
    var numberOfLines: Int = 4
    //保存数值
    var tiles = Array<Int>()
    //数值的副本
    var mtiles = Array<Int>()
    //
    var scoreDelegate: ScoreViewProtocol!
    //
    var bestScoreDelegate: ScoreViewProtocol!
    //
    var score: Int = 0
    //
    var bestScore: Int = 0
    //
    var maxValue: Int = 2048
    
    
    init(numberOfLines: Int, score: ScoreViewProtocol, bestScore: ScoreViewProtocol, maxValue: Int) {
        
        self.scoreDelegate = score
        self.bestScoreDelegate = bestScore
        self.maxValue = maxValue
        
        self.numberOfLines = numberOfLines
        tiles = Array<Int>(count: numberOfLines * numberOfLines, repeatedValue: 0)
        mtiles = Array<Int>(count: numberOfLines * numberOfLines, repeatedValue: 0)
        
        
        //resetTiles()
    }
    
    func changeScore(score: Int) {
        self.score += score
        if self.bestScore < self.score {
            self.bestScore = self.score
            bestScoreDelegate.scoreDidChanged(self.bestScore)
        }
        scoreDelegate.scoreDidChanged(self.score)
    }
    
    //
    func resetTiles() {
         tiles = Array<Int>(count: numberOfLines * numberOfLines, repeatedValue: 0)
         mtiles = Array<Int>(count: numberOfLines * numberOfLines, repeatedValue: 0)
         score = 0
    }
    func copyFromMtiles() {
        for i in 0..numberOfLines*numberOfLines {
            tiles[i] = mtiles[i]
        }
    }
    func copyToMtiles() {
        for i in 0..numberOfLines*numberOfLines {
            mtiles[i] = tiles[i]
        }
    }
    func reflowUp() {
        copyToMtiles()
        
        var index: Int
        for var i = numberOfLines - 1; i > 0; i-- {
            for j in 0..numberOfLines {
                
                index = i * numberOfLines + j
                if (mtiles[index - numberOfLines] == 0) && (mtiles[index] > 0) {
                    mtiles[index - numberOfLines] = mtiles[index]
                    mtiles[index] = 0
                    
                    
                    var tempIndex = index
                    while tempIndex + numberOfLines < mtiles.count {
                        if mtiles[tempIndex + numberOfLines] > 0 {
                            mtiles[tempIndex] = mtiles[tempIndex + numberOfLines]
                            mtiles[tempIndex + numberOfLines] = 0
                        }
                        tempIndex += numberOfLines
                    }
                }
            }
        }
        copyFromMtiles()
    }
    
    func mergeUp() {
        copyToMtiles()
        var index: Int
        for i in 0..numberOfLines-1 {
            for j in 0..numberOfLines {
                index = i * numberOfLines + j
                if (mtiles[index] > 0) && (mtiles[index + numberOfLines] == mtiles[index]) {
                    mtiles[index] *= 2
                    mtiles[index + numberOfLines] = 0
                    
                    changeScore(mtiles[index])
                }
            }
        }
            copyFromMtiles()
    }
        
    func reflowDown() {
        copyToMtiles()
        
        var index: Int
        for var i = 0; i < numberOfLines-1; i++ {
            for j in 0..numberOfLines {
                
                index = i * numberOfLines + j
                if (mtiles[index + numberOfLines] == 0) && (mtiles[index] > 0) {
                    mtiles[index + numberOfLines] = mtiles[index]
                    mtiles[index] = 0
                    
                    var tempIndex = index
                    while tempIndex - numberOfLines >= 0 {
                        if mtiles[tempIndex - numberOfLines] > 0 {
                            mtiles[tempIndex] = mtiles[tempIndex - numberOfLines]
                            mtiles[tempIndex - numberOfLines] = 0
                        }
                        tempIndex -= numberOfLines
                    }
                }
            }
        }
        copyFromMtiles()
    }
    func mergeDown() {
        copyToMtiles()
        var index: Int
        for var i = numberOfLines-1; i > 0; i-- {
            for j in 0..numberOfLines {
                index = i * numberOfLines + j
                if (mtiles[index] > 0) && (mtiles[index - numberOfLines] == mtiles[index]) {
                    mtiles[index] *= 2
                    mtiles[index - numberOfLines] = 0
                    changeScore(mtiles[index])

                }
            }
        }
        copyFromMtiles()
    }

    func reflowLeft() {
        
        copyToMtiles()
        
        var index: Int
        for i in 0..numberOfLines {
            for var j = numberOfLines-1; j > 0; j-- {
                
                index = i * numberOfLines + j
                if (mtiles[index - 1] == 0) && (mtiles[index] > 0) {
                    mtiles[index - 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var tempIndex = index
                    while tempIndex + 1 < ((i + 1) * numberOfLines) {
                        if mtiles[tempIndex + 1] > 0 {
                            mtiles[tempIndex] = mtiles[tempIndex + 1]
                            mtiles[tempIndex + 1] = 0
                        }
                        tempIndex += 1
                    }
                }
            }
        }
        copyFromMtiles()
    }
    func mergeLeft() {
        copyToMtiles()
        var index: Int
        for i in 0..numberOfLines {
            for j in 0..numberOfLines-1 {
                index = i * numberOfLines + j
                if (mtiles[index] > 0) && (mtiles[index + 1] == mtiles[index]) {
                    mtiles[index] *= 2
                    mtiles[index + 1] = 0
                    changeScore(mtiles[index])

                }
            }
        }
        copyFromMtiles()
    }
    
    func reflowRight() {
        copyToMtiles()
        
        var index: Int
        for i in 0..numberOfLines {
            for j in 0..(numberOfLines - 1) {
                
                index = i * numberOfLines + j
                if (mtiles[index + 1] == 0) && (mtiles[index] > 0) {
                    mtiles[index + 1] = mtiles[index]
                    mtiles[index] = 0
                    
                    var tempIndex = index
                    while tempIndex - 1 > (i * numberOfLines - 1) {
                        if mtiles[tempIndex - 1] > 0 {
                            mtiles[tempIndex] = mtiles[tempIndex - 1]
                            mtiles[tempIndex - 1] = 0
                        }
                        tempIndex -= 1
                    }
                }
            }
        }
        copyFromMtiles()
    }
    func mergeRight() {
        copyToMtiles()
        var index: Int
        for i in 0..numberOfLines {
            for var j = numberOfLines-1; j > 0; j-- {
                index = i * numberOfLines + j
                if (mtiles[index] > 0) && (mtiles[index - 1] == mtiles[index]) {
                    mtiles[index] *= 2
                    mtiles[index - 1] = 0
                    changeScore(mtiles[index])

                }
            }
        }
        copyFromMtiles()
    }

    
    /*
    * if return false, there is value
    */
    func setPosition(position:(Int, Int), value: Int) -> Bool {
        assert(position.0 >= 0 && position.0 < numberOfLines)
        assert(position.1 >= 0 && position.1 < numberOfLines)
        
        let (row, col) = position
        let index = numberOfLines * row + col
        let tempValue = tiles[index]
        if tempValue > 0 {
            println("row = \(row), col = \(col) ... there is value of \(tempValue)")
            return false
        }
        tiles[index] = value
        return true
    }
    
    func emptyPositions() -> Int[] {
        var emptyPos = Array<Int>()
        for i in 0..(numberOfLines * numberOfLines) {
            if tiles[i] == 0 {
                emptyPos += i
            }
        }
        
        return emptyPos
    }
    func isFull() -> Bool {
        if emptyPositions().count == 0 {
            println("All views is Full...")
            return true
        }
        return false
    }
    func gameDidSucceed() -> Bool{
        var value: Int
        for index in 0..numberOfLines*numberOfLines {
            if mtiles[index] >= maxValue {
                return true
            }
        }
        return false
    }
    
    
    
    
}
