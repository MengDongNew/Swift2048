//
//  PlayingViewController.swift
//  Swift2048
//
//  Created by mengdong on 14-6-25.
//  Copyright (c) 2014年 com.mengdong. All rights reserved.
//

import UIKit


enum Animation2048Type {
    case None        //无动画
    case New          //出现新方块动画
    case Marge     //合并动画
}
class PlayingViewController: UIViewController, UIAlertViewDelegate {

    /*设置方格边长*/
    var mLengthOfSide: Double = 50    /*设置方格之间缝隙*/
    var mGap: Double = 6
    /*设置方格行数和l列数*/
    var mLineNumber: Int = 4 {
    didSet {
        println("new line number = \(mLineNumber)")
        gameModel.numberOfLines = self.mLineNumber
        
        loadViews()
    }
    }

    //
    var controlView = ControlView()
    /*GameModel 对象*/
    var gameModel:GameModel!
    /*保存方块上所有的Label*/
    var tiles = Dictionary<NSIndexPath, TileView>() //= [:]
    /*保存Label上的数值*/
    var values = Dictionary<NSIndexPath, Int>()
    //
    var scoreLabel: ScoreLabel!
    //
    var bestScoreLabel:ScoreLabel!
    //
    var maxValue: Int = 2048 {
    didSet {
        println("new maxValue = \(maxValue)")
        gameModel.maxValue = self.maxValue
        resetGame()
    }
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.view.backgroundColor = UIColor.whiteColor()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
    }
    
    func loadViews() {
        
        loadChecksView()
        
        setupSwipeGesture()
        createScoreViews()
        createControlViews()
        
        self.gameModel = GameModel(numberOfLines: mLineNumber, score: scoreLabel, bestScore: bestScoreLabel, maxValue: maxValue)
        
        gameBegin()
    }
    
      func removeKeyTile(key: NSIndexPath) {
        
        var tile = tiles[key]
        //var value = values[key]
        
        tile!.removeFromSuperview()
        tiles.removeValueForKey(key)
        values.removeValueForKey(key)
    }
    
    func setupSwipeGesture() {
        let swipeUpGesture = UISwipeGestureRecognizer(target:self, action: Selector("swipeUp"))
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpGesture)
        
        let swipeDownGesture = UISwipeGestureRecognizer(target:self, action: Selector("swipeDown"))
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target:self, action: Selector("swipeLeft"))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftGesture)

        let swipeRightGesture = UISwipeGestureRecognizer(target:self, action: Selector("swipeRight"))
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightGesture)

    }
    
    func printTiles(ary: Array<Int>) {
        //let num = ary.count
        //for num; i ++) {
        for i in 0..ary.count {
            
            if (i + 1) % Int(mLineNumber) != 0 {
                print("\(ary[i])  ")
            } else {
                println("\(ary[i])\t")
            }
        }
        println()
    }
    func refleshUI() {
        
        var indexPath: NSIndexPath
        var index: Int
        var tile: TileView
        var value: Int
        
        for i in 0..mLineNumber {
            for j in 0..mLineNumber {
                indexPath = NSIndexPath(forRow: i, inSection: j)
                index = i * mLineNumber + j
                //数据模型有数据，UI上没有显示
                if (gameModel.mtiles[index] > 0) && (tiles[indexPath] == nil) {
                    insertTileToCheck((i, j), number: gameModel.mtiles[index], animation: Animation2048Type.New)
                }
                //数据模型没有值了，UI上有值
                if (gameModel.mtiles[index] == 0) && (tiles[indexPath] != nil){
                    var tile = tiles[indexPath]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(indexPath)
                    values.removeValueForKey(indexPath)
                }
                //数据模型和UI上都有数据
                if (gameModel.mtiles[index] > 0) && (tiles[indexPath] != nil) {
                    var value = values[indexPath]
                    if value != gameModel.mtiles[index] {
                        var tile = tiles[indexPath]!
                        tile.removeFromSuperview()
                        tiles.removeValueForKey(indexPath)
                        values.removeValueForKey(indexPath)
                        
                        insertTileToCheck((i, j), number: gameModel.mtiles[index], animation:Animation2048Type.Marge)
                    }
                }
            }
        }
        if gameModel.gameDidSucceed() {
            println("YOU WIN...")
            showSucceedAlertView()
            return
        }
        getRandomNumber()
    }
    
    func swipeUp() {
        println("swipeUp")
        printTiles(gameModel.tiles)
        gameModel.reflowUp()
        gameModel.mergeUp()
        gameModel.reflowUp()

        printTiles(gameModel.mtiles)
        
        refleshUI()
    }
    func swipeDown() {
        println("swipeDown")
        printTiles(gameModel.tiles)
        gameModel.reflowDown()
        gameModel.mergeDown()
        gameModel.reflowDown()

        printTiles(gameModel.mtiles)
        
        refleshUI()
            
    }
    func swipeLeft() {
        println("swipeLeft")
        printTiles(gameModel.tiles)
        gameModel.reflowLeft()
        gameModel.mergeLeft()
        gameModel.reflowLeft()
        
        printTiles(gameModel.mtiles)

       refleshUI()
    }
    func swipeRight() {
        println("swipeRight")
        printTiles(gameModel.tiles)
        gameModel.reflowRight()
        gameModel.mergeRight()
        gameModel.reflowRight()

        printTiles(gameModel.mtiles)
        
       refleshUI()
    }
    

    /* 
    *create ControlViews
    */
    func createControlViews() {
        
        var resetButton = controlView.createButtonWithTitle("重置", selector: "resetGame", sender: self)
        resetButton.frame = CGRectMake(30, 450, 100, 30)
        self.view.addSubview(resetButton)
        
        var addButton = controlView.createButtonWithTitle("添加", selector: "addNewNumber", sender: self)
        addButton.frame = CGRectMake(140, 450, 100, 30)
        self.view.addSubview(addButton)
    }
    

     func addNewNumber() {
        println("addNewNumber...")
        
        getRandomNumber()
    }
    
    //加载方格视图
    func loadChecksView() {
        
        for view : AnyObject in self.view.subviews {
            view.removeFromSuperview()
        }
        
        //x1和 x2 必须是CGFloat（Double）类型，Float不行
        var x1: CGFloat = 30
        var y1: CGFloat = 150
        
        //屏幕方格布局
        for i in 0..mLineNumber {
            y1 = 150
            for j in 0..mLineNumber {
                var aView = UIView(frame: CGRectMake(x1, y1, mLengthOfSide, mLengthOfSide))
                aView.backgroundColor =  UIColor.grayColor()
                self.view.addSubview(aView)
                y1 += mLengthOfSide + mGap
            }
            x1 += mLengthOfSide + mGap
        }
    }
    
    //获取随机数，出现90%出现2，%10出现4
    func getRandomNumber()  {
        
        if gameModel!.isFull() {
            println("Game Over !!!")
            return
        }
        
        let rando = arc4random_uniform(10);
        
        var needNumber = 2;
        
        if rando == 1 {
            needNumber = 4
        }
        println("needNumber = \(needNumber)")
        
        let row = Int(arc4random_uniform(UInt32(mLineNumber)))
        let col = Int(arc4random_uniform(UInt32(mLineNumber)))
        if gameModel!.setPosition((row, col), value: needNumber) == false {
            getRandomNumber()
            return
        }
        
        insertTileToCheck((row, col), number: needNumber, animation: Animation2048Type.New)
    }
    //向方格插入数字
    func insertTileToCheck(position: (Int, Int), number: Int, animation: Animation2048Type) {
        let (row, col) = position
        //println("position = \(position)")
        
        let x = 30.0 + Double(col) * (mLengthOfSide + mGap)
        let y = 150.0 + Double(row) * (mLengthOfSide + mGap)
        
        let tileView = TileView(frame: CGRectMake(x, y, mLengthOfSide, mLengthOfSide), value: number)
        self.view.addSubview(tileView)
        //self.view.bringSubviewToFront(tileView)
        
        var indexPath = NSIndexPath(forRow: row, inSection: col)
        /*保存每个新插入的 tileView*/
        tiles[indexPath] = tileView
        values[indexPath] = number
        //gameModel.tiles[row*mLineNumber + col] = number
        
        if animation == Animation2048Type.None {
            return
        }
        if animation == Animation2048Type.New {
            tileView.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        }
        if animation == Animation2048Type.Marge {
            tileView.layer.setAffineTransform(CGAffineTransformMakeScale(0.8, 0.8))
        }
        
        //设置方块出现时的动画效果
        //tileView.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        UIView.animateWithDuration(0.3, delay: 0.1, options: UIViewAnimationOptions.TransitionNone, animations: {
            () -> Void in
            tileView.layer.setAffineTransform(CGAffineTransformMakeScale(1.0, 1.0))
            
            },completion: {
                (Bool) -> Void in
                UIView.animateWithDuration(0.3, animations: {
                    () -> Void in
                    tileView.layer.setAffineTransform(CGAffineTransformIdentity)
                    }, completion: {
                        (Bool) -> Void in
                        
                    })
            })
        
    }
    
    func createScoreViews() {
        scoreLabel = ScoreLabel(frame: CGRectMake(30, 100, 100, 30))
        self.view.addSubview(scoreLabel)
        scoreLabel!.scoreDidChanged(0)
        
        bestScoreLabel = BestScoreLabel(frame: CGRectMake(140, 100, 100, 30))
        self.view.addSubview(bestScoreLabel)
        bestScoreLabel!.scoreDidChanged(0)
    }
    
    func resetGame() {
        println("resetGame....")
        for (key, tile) in tiles {
            tile.removeFromSuperview()
        }
        values.removeAll()
        
        gameModel!.resetTiles()
        scoreLabel.scoreDidChanged(0)
        
        gameBegin()
    }
    func gameBegin() {
        for i in 0..2 {
            getRandomNumber()
        }
        
    }
    
    func showSucceedAlertView() {
        var alertView = controlView.createAlertViewWithTitle("恭喜！", message: "您成功了！", sender: self, cancelButtonTitle: "取消")
        alertView.show()
    }
    
    func showFailedAlertView() {
        var alertView = controlView.createAlertViewWithTitle("哎！", message: "失败了！", sender: self, cancelButtonTitle: "再来一次")
        alertView.show()
    }
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        println("clickedButtonAtIndex...")
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
