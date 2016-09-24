//
//  SettingsViewController.swift
//  tippy
//
//  Created by SangHoon Lee on 9/16/16.
//  Copyright © 2016 SangHoon Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var defaultTipAmountSelectionControl: UISegmentedControl!
    
    override func loadView() {
        super.loadView()
        setupDefaultSelectionView()
    }
    
    private func setupDefaultSelectionView() {
        let tiplabels: [String] = Tip.TIP_OPTIONS.map{$0.label}
        defaultTipAmountSelectionControl = UISegmentedControl(items: tiplabels)
        defaultTipAmountSelectionControl.tintColor = UIColor.blueColor()
        defaultTipAmountSelectionControl.selectedSegmentIndex = 0
        
        let frame = UIScreen.mainScreen().bounds
        
        // How to get default width and height?
        // How to set x, y relative to label?
        defaultTipAmountSelectionControl.frame =
            CGRectMake(frame.minX + 10, frame.minY + 130, frame.width - 20, 30)
        
        self.view.insertSubview(defaultTipAmountSelectionControl, atIndex: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation to transparent to give consistent background color
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // retrieve the previous default tip index
        let defaults = NSUserDefaults.standardUserDefaults()
        defaultTipAmountSelectionControl.selectedSegmentIndex =
            defaults.integerForKey(KeyValueDBConstants.DEFAULT_TIP_INDEX)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // persist default tip index
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(
            defaultTipAmountSelectionControl.selectedSegmentIndex,
            forKey: KeyValueDBConstants.DEFAULT_TIP_INDEX
        )
        defaults.synchronize()
    }
}
