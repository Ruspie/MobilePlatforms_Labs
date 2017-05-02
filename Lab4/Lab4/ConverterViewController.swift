//  ViewController.swift
//  Lab1
//
//  Created by Admin on 07.02.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    enum ConverterError : Error{
        case argumentNilError
        case incorrectValueError
        case emptyTextFieldError
    }
    
    let converter = Converter()
    
    @IBOutlet weak var workStackView: UIStackView!
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var outputStackView: UIStackView!
    
    
    @IBOutlet weak var InputAmountTextField: UITextField!
    @IBOutlet weak var AmounInUSDLabel: UILabel!
    @IBOutlet weak var AmountInEURLabel: UILabel!
    @IBOutlet weak var AmountInRUBLabel: UILabel!
    
    @IBAction func OnClickButtonConvert(_ sender: UIButton) {
        view.endEditing(true)
        do {
            
            if (InputAmountTextField.text ?? "").isEmpty {
                throw ConverterError.emptyTextFieldError
            }
            
            let inputAmount = Double(InputAmountTextField.text!)
            if (inputAmount == nil){
                throw ConverterError.argumentNilError
            }
            if (inputAmount! < 0){
               throw ConverterError.incorrectValueError
            }
            
            let converted = converter.getAllConvertedAmount(amountInBYN: inputAmount!)
            showResult(convertedResult: converted)
            
        }
        catch ConverterError.emptyTextFieldError{
            showAlert(message: "Fill in the input field amount!")
            let converted = converter.getAllConvertedAmount(amountInBYN: 1)
            showResult(convertedResult: converted)
        }
        catch ConverterError.argumentNilError {
            showAlert(message: "Amount is incorrect, re-enter amount!")
        }
        catch ConverterError.incorrectValueError {
            showAlert(message: "Amount can not be negative, please enter a valid amount!")
        }
        catch{
            showAlert(message: "Something went wrong!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let converted = converter.getAllConvertedAmount(amountInBYN: 1)
        showResult(convertedResult: converted)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showAlert(message : String){
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
        show(alert, sender: self)
    }
    
    func showResult(convertedResult: [Currency:Double]) {
        AmounInUSDLabel.text = "USD : \(convertedResult[Currency.USD]!)$"
        AmountInEURLabel.text = "EUR : \(convertedResult[Currency.EUR]!)€"
        AmountInRUBLabel.text = "RUB : \(convertedResult[Currency.RUB]!)₽"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeAxis()
    }
    
    func changeAxis(){
        if UIDevice.current.orientation.isLandscape {
            //workStackView.axis = UILayoutConstraintAxis.horizontal
            inputStackView.axis = .horizontal
            outputStackView.axis = .horizontal
        } else {
            //workStackView.axis = UILayoutConstraintAxis.vertical
            inputStackView.axis = .vertical
            outputStackView.axis = .vertical
        }
    }
}
