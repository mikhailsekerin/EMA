//
//  ViewController.swift
//  EMA
//
//  Created by Михаил Секерин on 25.10.18.
//  Copyright © 2018 Mikhail Sekerin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tiPidorLabel: UILabel!
    
    @IBOutlet weak var whatAHandsomeBoiii: UIImageView!
    @IBOutlet weak var knopka: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        whatAHandsomeBoiii.isHidden = true
        knopka.layer.borderWidth = 1
        knopka.layer.borderColor = UIColor.blue.cgColor
        knopka.layer.cornerRadius = 5
        whatAHandsomeBoiii.layer.cornerRadius = 5
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func onKnopkaTap(_ sender: Any) {
        tiPidorLabel.text = "ТЫ ПИДОР"
        knopka.isHidden = true
        whatAHandsomeBoiii.isHidden = false
        
    }
    

}

