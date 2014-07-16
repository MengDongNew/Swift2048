//
//  TileView.swift
//  Swift2048
//
//  Created by mengdong on 14-6-30.
//  Copyright (c) 2014年 com.mengdong. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    /*
    *不同数字使用不同的颜色
    */
    let colorOfTile = [
        2: UIColor.redColor(),
        4: UIColor.orangeColor(),
        8: UIColor.greenColor(),
        16: UIColor.brownColor(),
        32: UIColor.purpleColor(),
        64: UIColor.magentaColor(),
        128: UIColor.yellowColor(),
        256: UIColor.cyanColor(),
        512: UIColor.blueColor(),
        1024: UIColor.grayColor(),
        2048: UIColor.darkGrayColor()
        
    ]

    /*
    *use to add number
    */
    var numberLabel: UILabel!
    /*
    *number of label
    */
    var value: Int = 0 {
    didSet{
        backgroundColor = colorOfTile[value]
        numberLabel.text = "\(value)"
    }
    }
    
    /*
    *TileView 的初始化方法
    *参数：frame ， value
    */
    
    init(frame: CGRect, value: Int) {
        super.init(frame: frame)
        backgroundColor = colorOfTile[value]
        
        numberLabel = UILabel(frame: self.bounds)
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = UIFont(name: "微软黑体", size: 20.0)
        numberLabel.text = "\(value)"
        addSubview(numberLabel)
        
        self.value = value
        
        
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
