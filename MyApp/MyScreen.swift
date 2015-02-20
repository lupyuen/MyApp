//
//  MyScreen.swift
//  MyApp
//
//  Created by Luppy on 15/2/15.
//  Copyright (c) 2015 Lee Lup Yuen. All rights reserved.
//

import UIKit

class MyScreen: UIViewController {

    var myCode = MyCode()
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var textbox2: UITextField!
    @IBOutlet weak var textbox3: UITextField!
    @IBOutlet weak var textbox4: UITextField!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var revealViewController = self.revealViewController()
        if (revealViewController != nil)
        {
            var rearViewController = parentViewController
            //var tabContainer: TabContainer = revealViewController.rearViewController[0] as TabContainer
            //var menuButton = tabContainer.menuButton
            //menuButton.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
            
            //self.sidebarButton.setTarget(self.revealViewController)
            //self.sidebarButton setAction: @selector( revealToggle: )];
            //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button1IsPressed(sender: AnyObject) {
        myCode.button1IsPressed(self)
    }
    
    @IBAction func button2IsPressed(sender: AnyObject) {
        myCode.button2IsPressed(self)
    }
    
    @IBAction func button3IsPressed(sender: AnyObject) {
        myCode.button3IsPressed(self)
    }
    
    @IBAction func button4IsPressed(sender: AnyObject) {
        myCode.button4IsPressed(self)
    }
    


}

