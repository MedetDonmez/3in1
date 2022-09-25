//
//  CheckboxViewController.swift
//  3in1
//
//  Created by Medet Dönmez on 23.09.2022.
//

import UIKit
import ChameleonFramework

class CheckboxViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    var delegate: statusProtocol?
    var index: Int? // this variable will be equal to index of selected row.
    var bar: Bool? // this variable will be equal to status of selected row.
    
    override func viewDidLoad() {
        setupUI()
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        //first status of our button will be according to our item status.
        switchButton.isOn = bar!
    }
    
    func setupUI() {
        infoLabel.layer.cornerRadius = 8
        view.backgroundColor = FlatSkyBlue()
        infoLabel.backgroundColor = FlatSand()
    }

    
    @IBAction func switchClicked(_ sender: UISwitch) {
        //when switch is clicked our Item status will be changed isdone or not.
        delegate?.status(index: index!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.navigationController?.popViewController(animated: true)
        }
    )}

}


