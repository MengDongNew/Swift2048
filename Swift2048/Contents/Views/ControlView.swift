//
//  ControlView.swift
//  Swift2048
//
//  Created by mengdong on 14-6-30.
//  Copyright (c) 2014年 com.mengdong. All rights reserved.
//

import UIKit

class ControlView: NSObject {
    
    var defaultFrame = CGRectMake(0, 0, 100, 30)
    
    func createButtonWithTitle(title: String, selector: Selector, sender: AnyObject) -> UIButton {
        var button = UIButton(frame: defaultFrame)
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState:UIControlState.Highlighted)
        button.titleLabel.textColor = UIColor.whiteColor()
        button.titleLabel.font = UIFont.systemFontOfSize(16)
        
        button.addTarget(sender, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func createLabelWithTitle(title: String) -> UILabel {
        var label = UILabel(frame: defaultFrame)
        label.text = title
        label.backgroundColor = UIColor.clearColor()
        
        return label
    }
    
    func createTextFieldWithText(text: String, selector: Selector, sender: UITextFieldDelegate) -> UITextField {
        var textfield = UITextField(frame: defaultFrame)
        textfield.placeholder = "2048"
        textfield.text = text
        textfield.backgroundColor = UIColor.clearColor()
        textfield.textColor = UIColor.redColor()
        textfield.borderStyle = UITextBorderStyle.RoundedRect
        
        textfield.adjustsFontSizeToFitWidth = true
        textfield.delegate = sender
        return textfield
    }
    
    func createSegmentedControlWithItems(items: String[], selector: Selector, sender: AnyObject) -> UISegmentedControl {
        var segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = defaultFrame
        segmentedControl.segmentedControlStyle = UISegmentedControlStyle.Bordered
        //segmentedControl.momentary = true
        segmentedControl.addTarget(sender, action: selector, forControlEvents: UIControlEvents.ValueChanged)
        
        return segmentedControl
    }
    
    func createAlertViewWithTitle(title: String, message: String, sender: AnyObject, cancelButtonTitle: String) -> UIAlertView {
        var alertView = UIAlertView(title: title, message: message, delegate: sender, cancelButtonTitle: cancelButtonTitle)
        return alertView
    }
    
}
