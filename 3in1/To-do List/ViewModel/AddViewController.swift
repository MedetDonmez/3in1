//
//  AddViewController.swift
//  3in1
//
//  Created by Medet Dönmez on 24.09.2022.
//

import UIKit
import ChameleonFramework

class AddViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    var delegate : addProtocol?
    @IBOutlet weak var elementTextField: UITextField!
    

    override func viewDidLoad() {

        setupUI()
        super.viewDidLoad()

    }
    
    func setupUI() {
        view.backgroundColor = FlatSkyBlue()
        addButton.backgroundColor = FlatSand()
        addButton.layer.cornerRadius = 8
        elementTextField.layer.cornerRadius = 8
        addButton.titleLabel?.text = "Add"
        elementTextField.backgroundColor = FlatSand()
        elementTextField.delegate = self
        
    }

    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        delegate?.addItem(title: elementTextField.text ?? "empty")
        navigationController?.popViewController(animated: true)
    }
    

}
extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        elementTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Write an element"
            return false
        }
    }
}
    
