//
//  ScoreLabel.swift
//  Swift2048
//
//  Created by mengdong on 14-7-1.
//  Copyright (c) 2014年 com.mengdong. All rights reserved.
//

import UIKit

protocol ScoreViewProtocol {
    func scoreDidChanged(score: Int)
}
class ScoreLabel: UIView, ScoreViewProtocol {

    var label: UILabel!
    let defaultFrame = CGRectMake(0, 0, 100, 300)
    
    var score: Int = 0{
    didSet {
        label.text = "分数:\(score)"
    }
    }
    init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame:self.bounds)
        label.textAlignment = NSTextAlignment.Center
        backgroundColor = UIColor.cyanColor()
        label.font = UIFont.systemFontOfSize(14)
        self.addSubview(label)
    }
    
    func scoreDidChanged(newScore: Int) {
        self.score = newScore
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
class BestScoreLabel: ScoreLabel, ScoreViewProtocol {
    
    var bestScore: Int = 0 {
    didSet{
        label!.text = "最高分: \(bestScore)"
    }
    
    }
    
    override func scoreDidChanged(newScore: Int) {
        bestScore = newScore
    }
}

