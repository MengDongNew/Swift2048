// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var label = UILabel(frame:CGRectMake(10, 20, 100, 100))
//label.layer.cornerRadius = 50.0
label.backgroundColor = UIColor.redColor()
var label1 = UILabel(frame:CGRectMake(0, 0, 50, 50))
label1.backgroundColor = UIColor.greenColor()
label.addSubview(label1)
