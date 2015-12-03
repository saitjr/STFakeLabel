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
        self.flag++
        
        if tag == 100 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.STFakeAnimationDown, toText: toText)
            return
        }
        if tag == 101 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.STFakeAnimationLeft, toText: toText)
            return
        }
        if tag == 102 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.STFakeAnimationRight, toText: toText)
            return
        }
        if tag == 103 {
            self.fakeLabel.st_startAnimation(UILabel.STFakeAnimationDirection.STFakeAnimationUp, toText: toText)
            return
        }
    }
}