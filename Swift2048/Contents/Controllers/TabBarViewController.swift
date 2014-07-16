//
//  TabBarViewController.swift
//  Swift2048
//
//  Created by mengdong on 14-6-25.
//  Copyright (c) 2014年 com.mengdong. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var playingVC = PlayingViewController(nibName: nil, bundle: nil)
        playingVC.title = "Playing"
        var settingVC = SettingViewController(viewController: playingVC)
        settingVC.title = "Setting"
        
        self.viewControllers = [
            playingVC,
            settingVC
        ]
        self.selectedIndex = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
