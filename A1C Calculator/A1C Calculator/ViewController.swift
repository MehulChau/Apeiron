//
//  ViewController.swift
//  A1C Calculator
//
//  Created by Mehul Chaudhari on 8/16/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var estimatedLabel: UILabel!
    @IBOutlet weak var pleaseEnterLabel: UILabel!
    @IBOutlet weak var unitsSegementedControl: UISegmentedControl!
    @IBOutlet weak var pageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var glucoseLevelLabel: UILabel!
    @IBOutlet weak var percentInput: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didMeasurementChange(_ sender: UISegmentedControl) {
        var A1CLevel:Double = 0.0
        if sender.selectedSegmentIndex == 0 {
            if pageSegmentedControl.selectedSegmentIndex == 0 {
                switchToL()
            }
            if pageSegmentedControl.selectedSegmentIndex == 1 {
                unitsLabel.text = " "
                pleaseEnterLabel.text = "Please enter your eAG level (mmol/L)"
                let input = Double(percentInput.text!)
                guard input != nil else {
                        return
                    }
                A1CLevel = ((Double(percentInput.text!)! * 18) + 46.7)/28.7
                if A1CLevel >= 0 {
                    glucoseLevelLabel.text = String(format: "%.02f", A1CLevel) + "%"
                    getA1CRating(glucoseLevel: A1CLevel)
                }
                else {
                    glucoseLevelLabel.text = "0.00"
                    ratingLabel.text = " "
                }
            }
        }
        else if sender.selectedSegmentIndex == 1 {
            if pageSegmentedControl.selectedSegmentIndex == 0 {
                switchToDL()
            }
            if pageSegmentedControl.selectedSegmentIndex == 1 {
                pleaseEnterLabel.text = "Please enter your eAG level (mg/dL)"
                unitsLabel.text = " "
                let input = Double(percentInput.text!)
                guard input != nil else {
                        return
                    }
                A1CLevel = ((Double(percentInput.text!)! + 46.7) / 28.7)
                if A1CLevel >= 0 {
                    glucoseLevelLabel.text = String(format: "%.02f", A1CLevel) + "%"
                    getA1CRating(glucoseLevel: A1CLevel)
                }
                else {
                    glucoseLevelLabel.text = "0.00"
                    ratingLabel.text = " "
                }
            }
        }
    }
    
    @IBAction func didViewChange(_ sender: UISegmentedControl) {
        var glucoseLevel:Double = 0.0
        var A1CLevel: Double = 0.0
        if sender.selectedSegmentIndex == 0 {
            pleaseEnterLabel.text = "Please enter your Hemoglobin A1C (%)"
            estimatedLabel.text = "Your estimated average glucose level is:"
            let input = Double(percentInput.text!)
            guard input != nil else {
                    return
                }
            if unitsSegementedControl.selectedSegmentIndex == 0 {
                unitsLabel.text = "millimoles per liter (mmol/L)"
                glucoseLevel = ((Double(percentInput.text!)! * 28.7) - 46.7)/18
            }
            else if unitsSegementedControl.selectedSegmentIndex == 1 {
                unitsLabel.text = "milligrams per deciliter (mg/dL)"
                glucoseLevel = ((Double(percentInput.text!)! * 28.7) - 46.7)
            }
            
            if glucoseLevel >= 0 {
                glucoseLevelLabel.text = String(format: "%.02f", glucoseLevel)
                if unitsSegementedControl.selectedSegmentIndex == 0 {
                    getLRating(glucoseLevel: glucoseLevel)
                }
                else if unitsSegementedControl.selectedSegmentIndex == 1 {
                    getDLRating(glucoseLevel: glucoseLevel)
                }
            }
            else {
                glucoseLevelLabel.text = "0.00"
                ratingLabel.text = " "
            }
            
        }
        else if sender.selectedSegmentIndex == 1 {
            unitsLabel.text = " "
            let input = Double(percentInput.text!)
            guard input != nil else {
                    return
                }
            if unitsSegementedControl.selectedSegmentIndex == 0 {
                A1CLevel = ((Double(percentInput.text!)! * 18) + 46.7)/28.7
            }
            else if unitsSegementedControl.selectedSegmentIndex == 1 {
                A1CLevel = ((Double(percentInput.text!)! + 46.7) / 28.7)
            }
            
            if A1CLevel >= 0 {
                glucoseLevelLabel.text = String(format: "%.02f", A1CLevel) + "%"
                if unitsSegementedControl.selectedSegmentIndex == 0 {
                    getA1CRating(glucoseLevel: A1CLevel)
                }
                else if unitsSegementedControl.selectedSegmentIndex == 1 {
                    getA1CRating(glucoseLevel: A1CLevel)
                }
            }
            else {
                glucoseLevelLabel.text = "0.00"
                ratingLabel.text = " "
            }
            if unitsSegementedControl.selectedSegmentIndex == 0 {
                pleaseEnterLabel.text = "Please enter your eAG level (mmol/L)"
                estimatedLabel.text = "Your estimated HbA1c level is:"
            }
            else if unitsSegementedControl.selectedSegmentIndex == 1 {
                pleaseEnterLabel.text = "Please enter your eAG level (mg/dL)"
                estimatedLabel.text = "Your estimated HbA1c level is:"
            }
        }
    }
    
    @IBAction func convertPressed(_ sender: Any) {
        var glucoseLevel:Double = 0.0
        var A1CLevel:Double = 0.0
        let input = Double(percentInput.text!)
        guard input != nil else {
                showAlert()
                return
            }
        if Double(percentInput.text!)! >= 0 {
            if pageSegmentedControl.selectedSegmentIndex == 0 {
                if unitsSegementedControl.selectedSegmentIndex == 0 {
                    glucoseLevel = ((Double(percentInput.text!)! * 28.7) - 46.7)/18
                }
                else if unitsSegementedControl.selectedSegmentIndex == 1 {
                    glucoseLevel = ((Double(percentInput.text!)! * 28.7) - 46.7)
                }
                
                if glucoseLevel >= 0 {
                    glucoseLevelLabel.text = String(format: "%.02f", glucoseLevel)
                    if unitsSegementedControl.selectedSegmentIndex == 0 {
                        getLRating(glucoseLevel: glucoseLevel)
                    }
                    else if unitsSegementedControl.selectedSegmentIndex == 1 {
                        getDLRating(glucoseLevel: glucoseLevel)
                    }
                }
                else {
                    glucoseLevelLabel.text = "0.00"
                    ratingLabel.text = " "
                }
            }
            else if pageSegmentedControl.selectedSegmentIndex == 1 {
                if unitsSegementedControl.selectedSegmentIndex == 0 {
                    A1CLevel = ((Double(percentInput.text!)! * 18) + 46.7)/28.7
                }
                else if unitsSegementedControl.selectedSegmentIndex == 1 {
                    A1CLevel = ((Double(percentInput.text!)! + 46.7) / 28.7)
                }
                
                if A1CLevel >= 0 {
                    glucoseLevelLabel.text = String(format: "%.02f", A1CLevel) + "%"
                    if unitsSegementedControl.selectedSegmentIndex == 0 {
                        getA1CRating(glucoseLevel: A1CLevel)
                    }
                    else if unitsSegementedControl.selectedSegmentIndex == 1 {
                        getA1CRating(glucoseLevel: A1CLevel)
                    }
                }
                else {
                    glucoseLevelLabel.text = "0.00"
                    ratingLabel.text = " "
                }
            }
        }
    }
    
    func switchToDL() {
        unitsLabel.text = "milligrams per deciliter (mg/dL)"
        if pageSegmentedControl.selectedSegmentIndex == 0 {
            let input = Double(percentInput.text!)
            guard input != nil else {
                    //showAlert()
                    return
                }
            if Double(percentInput.text!)! >= 0 {
                let glucoseLevel:Double = ((Double(percentInput.text!)! * 28.7) - 46.7)
                if glucoseLevel >= 0 {
                    glucoseLevelLabel.text = String(format: "%.02f", glucoseLevel)
                    getDLRating(glucoseLevel: glucoseLevel)
                }
                else {
                    glucoseLevelLabel.text = "0.00"
                }
            }
        }
        else if pageSegmentedControl.selectedSegmentIndex == 1 {
            pleaseEnterLabel.text = "Please enter your eAG level (mg/dL)"
            estimatedLabel.text = "Your estimated HbA1c level is:"
        }
    }
    
    func switchToL() {
        unitsLabel.text = "millimoles per liter (mmol/L)"
        if pageSegmentedControl.selectedSegmentIndex == 0 {
            let input = Double(percentInput.text!)
            guard input != nil else {
                    //showAlert()
                    return
                }
            if Double(percentInput.text!)! >= 0 {
                let glucoseLevel:Double = ((Double(percentInput.text!)! * 28.7) - 46.7) / 18
                if glucoseLevel >= 0 {
                    glucoseLevelLabel.text = String(format: "%.02f", glucoseLevel)
                    getLRating(glucoseLevel: glucoseLevel)
                }
                else {
                    glucoseLevelLabel.text = "0.00"
                }
            }
        }
        else if pageSegmentedControl.selectedSegmentIndex == 1 {
            pleaseEnterLabel.text = "Please enter your eAG level (mmol/L)"
            estimatedLabel.text = "Your estimated HbA1c level is:"
        }
    }
    
    func getLRating(glucoseLevel: Double) {
        if glucoseLevel <= 6.5 {
            ratingLabel.textColor = .green
            ratingLabel.text = "NORMAL"
        }
        else if 6.5 < glucoseLevel && glucoseLevel <= 7.6 {
            ratingLabel.textColor = .orange
            ratingLabel.text = "PREDIABETIC"
        }
        else if glucoseLevel > 7.6 {
            ratingLabel.textColor = .red
            ratingLabel.text = "DIABETIC"
        }
    }
    
    func getDLRating(glucoseLevel: Double) {
        if glucoseLevel <= 117 {
            ratingLabel.textColor = .green
            ratingLabel.text = "NORMAL"
        }
        else if 117 < glucoseLevel && glucoseLevel <= 136.8 {
            ratingLabel.textColor = .orange
            ratingLabel.text = "PREDIABETIC"
        }
        else if glucoseLevel > 136.8 {
            ratingLabel.textColor = .red
            ratingLabel.text = "DIABETIC"
        }
    }
    
    func getA1CRating(glucoseLevel: Double) {
        if glucoseLevel <= 5.7 {
            ratingLabel.textColor = .green
            ratingLabel.text = "NORMAL"
        }
        else if 5.7 < glucoseLevel && glucoseLevel <= 6.4 {
            ratingLabel.textColor = .orange
            ratingLabel.text = "PREDIABETIC"
        }
        else if glucoseLevel > 6.4 {
            ratingLabel.textColor = .red
            ratingLabel.text = "DIABETIC"
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter a numeric value over zero", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            self.percentInput.text = ""
        }))
        present(alert, animated: true)
    }


}
extension UIViewController {
func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}

