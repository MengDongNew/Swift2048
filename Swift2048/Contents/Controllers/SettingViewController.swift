//
//  SettingViewController.swift
//  Swift2048
//
//  Created by mengdong on 14-6-25.
//  Copyright (c) 2014年 com.mengdong. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {

    
    //用于传值
    var playingVC: PlayingViewController!
    //用于设置行数和列数
    var textField: UITextField!
    //
    let segmentedValues = [3, 4, 5]
    //用于设置游戏模式
    var segmentedControl: UISegmentedControl!
    //textField的label
    var tLabel: UILabel!
    //segmentedControl的label
    var sLabel: UILabel!
    
    
    init(viewController: PlayingViewController) {
        super.init(nibName: nil, bundle: nil)
        playingVC = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        createViews()
        
    }

    func createViews() {
        var controlView = ControlView()
        
        tLabel = controlView.createLabelWithTitle("请设置您挑战的目标，如: 2048")
        tLabel.frame = CGRectMake(30, 100, 250, 30)
        self.view.addSubview(tLabel)

        textField = controlView.createTextFieldWithText(String(playingVC.maxValue), selector: nil, sender: self)
        textField.frame = CGRectMake(30, 150, 100, 30)
        textField.clearsOnBeginEditing = true
        textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        textField.returnKeyType = UIReturnKeyType.Done
        self.view.addSubview(textField)
        
        sLabel = controlView.createLabelWithTitle("请设置方格的行数和列数，如: 4*4 ")
        sLabel.frame = CGRectMake(30, 220, 250, 60)
        sLabel.numberOfLines = 0
        self.view.addSubview(sLabel)
        
        segmentedControl = controlView.createSegmentedControlWithItems(["3*3", "4*4", "5*5"], selector: Selector("lineNumbersDidChanged"), sender: self)
        segmentedControl.frame = CGRectMake(30, 300, 260, 30)
        segmentedControl.selectedSegmentIndex = 1
        self.view.addSubview(segmentedControl)
    }
    func lineNumbersDidChanged() {
        println("lineNumbersDidChanged....")
        playingVC.mLineNumber = segmentedValues[segmentedControl.selectedSegmentIndex]
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        
        if textField.text != String(playingVC.maxValue) {
            playingVC.maxValue = textField.text.toInt()!
        }
        
        return true
    }
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
