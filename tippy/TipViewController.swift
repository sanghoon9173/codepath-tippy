//
//  ViewController.swift
//  tippy
//
//  Created by SangHoon Lee on 9/14/16.
//  Copyright © 2016 SangHoon Lee. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var resultContainer: UIView!
    @IBOutlet weak var tipPercentageSegmentedControl: UISegmentedControl!

    private let billCacheTimeInMin = 50
    private let resultViewAnimDuration = 0.4
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    private var tipAmount: Double = 0 {
        didSet { tipAmountLabel.text = StringUtils.formatToLocaleCurrencyString(tipAmount) }
    }
    
    private var totalAmount: Double = 0 {
        didSet { totalAmountLabel.text = StringUtils.formatToLocaleCurrencyString(totalAmount) }
    }
    
    private var billAmount: Double {
        get {
            return Double(billTextField.text!) ?? 0
        }
    }
    
    @IBAction func onTapBackground(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onTipPercentageSegmentedControlChanged(sender: UISegmentedControl) {
        calculateTip()
    }
    
    @IBAction func onBillTextFieldChanged(sender: UITextField) {
        showOrHideResultView()
        calculateTip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set placeholder to the currency symbol
        let placeholder = NSAttributedString(
            string: StringUtils.NUMBER_FORMATTER.currencySymbol,
            attributes: [NSForegroundColorAttributeName : UIColor.blueColor()]
        )
        billTextField.attributedPlaceholder = placeholder
        
        // add timer to remember bill amount for given time
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(TipViewController.saveCurrentBillAmountWithTime),
            name: UIApplicationDidEnterBackgroundNotification, object: nil
        )
        
        // set navigation to transparent to give consistent background color
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
        
        // hide result container
        self.resultContainer.alpha = 0
        
        retrievePreviousBillAmountIfPossible()
        billTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        retrievePreviousDefaultTipIndex()
    }
    
    private func calculateTip() {
        tipAmount = Tip.TIP_OPTIONS[tipPercentageSegmentedControl.selectedSegmentIndex].percentage * billAmount
        totalAmount = billAmount + tipAmount
    }
    
    private func showOrHideResultView() {
        if billTextField.text != nil && !billTextField.text!.isEmpty {
            UIView.animateWithDuration(resultViewAnimDuration) {
                self.resultContainer.alpha = 1
            }
        } else {
            UIView.animateWithDuration(0.4) {
                self.resultContainer.alpha = 0
            }
        }
    }
    
    private func retrievePreviousDefaultTipIndex() {
        tipPercentageSegmentedControl.selectedSegmentIndex =
            userDefaults.integerForKey(KeyValueDBConstants.DEFAULT_TIP_INDEX)
        
        // notify the value change listener
        tipPercentageSegmentedControl.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    private func retrievePreviousBillAmountIfPossible() {
        if let previousAppCloseTime = userDefaults.objectForKey(KeyValueDBConstants.APP_CLOSE_TIME) {
            let currentDate = NSDate()
            let addTime = (previousAppCloseTime as! NSDate).addSeconds(billCacheTimeInMin)
            if addTime.isGreaterThanDate(currentDate) {
                if let previousBill = userDefaults.objectForKey(KeyValueDBConstants.APP_CLOSE_BILL_AMOUNT) {
                    let previousBillString = (previousBill as! String)
                    // retrieve the previous string on UI thread
                    dispatch_async(dispatch_get_main_queue(), {
                        self.billTextField.text = previousBillString
                        self.billTextField.sendActionsForControlEvents(UIControlEvents.EditingChanged)
                    })
                }
            }
        }
    }
    
    @objc private func saveCurrentBillAmountWithTime() {
        if billTextField.text != nil && !billTextField.text!.isEmpty {
            userDefaults.setObject(
                NSDate(),
                forKey: KeyValueDBConstants.APP_CLOSE_TIME
            )
            userDefaults.setObject(billTextField.text!, forKey: KeyValueDBConstants.APP_CLOSE_BILL_AMOUNT)
            userDefaults.synchronize()
        }
    }
}