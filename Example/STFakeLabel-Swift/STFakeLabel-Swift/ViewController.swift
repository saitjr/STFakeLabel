//
//  ViewController.swift
//  STFakeLabel-Swift
//
//  Created by TangJR on 12/4/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fakeLabel: UILabel!
    private var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonTapped(sender: UIButton) {
        let tag = sender.tag
        let toText = flag % 2 == 1 ? "EGG" : "FALL"
        flag++
        
        if tag == 100 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.Down, toText: toText)
            return
        }
        if tag == 101 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.Left, toText: toText)
            return
        }
        if tag == 102 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.Right, toText: toText)
            return
        }
        if tag == 103 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.Up, toText: toText)
            return
        }
    }
}