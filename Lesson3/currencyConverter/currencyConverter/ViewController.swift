//
//  ViewController.swift
//  currencyConverter
//
//  Created by Andraz Kuret on 19. 10. 15.
//  Copyright © 2015 Andraz Kuret. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIPickerViewDelegate {
    
    @IBOutlet weak var firstCurrency: UIPickerView!
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var rateText: UITextField!
    
    @IBAction func eurSelector(sender: UIButton) {
        convertAndDisplay(sender.self.currentTitle!)
    }
    @IBAction func usdSelector(sender: UIButton) {
        convertAndDisplay(sender.self.currentTitle!)
    }
    @IBAction func jpySelector(sender: UIButton) {
        convertAndDisplay(sender.self.currentTitle!)
    }
    
    @IBOutlet weak var resultToDisplay: UILabel!
    @IBAction func clear(sender: UIButton) {
        numberInput.text = "0"
        resultToDisplay.text = "0"
    }
    var pickerData: [String] = [String]()
    var defaultValue: String = "EUR"
    var buttonTitle: String = ""
    
    let EurRates = (usd: 1.13, jpy: 135.29)
    let UsdRates = (eur: 0.88, jpy: 119.38)
    let JpyRates : Double = 0.01
    var rate: Double = 0.01
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    override func viewDidLoad() {
    //    let stringToNumber = NSNumberFormatter().numberFromString(numberInput.text!)!
        pickerData = ["EUR","USD","JPY"]
        initKeyBoardOnlyNum()


        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initKeyBoardOnlyNum() {
        numberInput.text = "0"
        numberInput.keyboardType = UIKeyboardType.DecimalPad
        numberInput.clearsOnInsertion = true
    }
    

    func selectRate(firstCurrency: String,secondCurrency: String) {
        switch(firstCurrency){
        case("EUR"):
            if secondCurrency == "USD" { rate = UsdRates.eur }
            else { rate = JpyRates }
        case("USD"):
            if secondCurrency == "EUR" { rate = EurRates.usd }
            else { rate = JpyRates }
        case("YPN"):
            switch(secondCurrency) {
            case("EUR"):
                rate = EurRates.jpy
            case("USD"):
                rate = UsdRates.jpy
            default:
                rate = JpyRates
            }
        default:
            rate = JpyRates
        }
        buttonTitle = secondCurrency
    }
    
    func convertAndDisplay(currentTitle: String) {
        selectRate(defaultValue, secondCurrency: currentTitle)
        let stringToNumber = NSNumberFormatter().numberFromString(numberInput.text!)!
        let  result = convert(Double(stringToNumber), startCurrency: "\(defaultValue)", targetCurrency: rate)
        resultToDisplay.text = "\(result.convertedValue)"
        rateText.text = "Menjalni tečaj: 1 \(defaultValue) = \(rate) \(buttonTitle)"
    }

    func convert(amount: Double, startCurrency: String, targetCurrency: Double) -> (convertedValue: Double, targetCurrency: Double) {
        let convertedValue = amount * targetCurrency
        return (convertedValue, targetCurrency)
    }
    
//    init pickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent compunent: Int) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaultValue = pickerData[row]
    }

}

