//
//  KeyChainViewController.swift
//  AppDatabase
//
//  Created by 김동욱 on 10/11/23.
//

import UIKit

final class KeyChainViewController: UIViewController {

    @IBOutlet weak var toBeReadLabel: UILabel!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var toBeSavedTextField: UITextField!
    @IBOutlet weak var writeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func touchUpWriteButton() {
        guard let service = serviceTextField.text,
              let key = keyTextField.text,
              let text = toBeSavedTextField.text,
              service != "",
              key != "",
              text != "" else { return }
        
        KeyChainUtil.writeToKeyChain(service, key, text)
        toBeSavedTextField.text = ""
    }
    
    @IBAction func touchUpReadButton() {
        guard let service = serviceTextField.text,
              let key = keyTextField.text,
              service != "",
              key != "" else { return }
        
        let text = KeyChainUtil.readFromKeyChain(service, key)
        
        if text == nil {
            toBeReadLabel.text = "저장된 데이터가 없습니다."
        } else {
            toBeReadLabel.text = text
        }
    }
    
    @IBAction func touchUpDeleteButton() {
        guard let service = serviceTextField.text,
              let key = keyTextField.text,
              service != "",
              key != "" else { return }
        
        KeyChainUtil.deleteFromKeychain(service, key)
    }
}
