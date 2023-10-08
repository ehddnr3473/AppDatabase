//
//  UserDefaultsViewController.swift
//  AppDatabase
//
//  Created by 김동욱 on 10/4/23.
//

import UIKit

final class UserDefaultsViewController: UIViewController {
    @IBOutlet weak var savedTextLabel: UILabel!
    @IBOutlet weak var toBeSavedTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedTextLabel.text = UserDefaults.standard.string(forKey: Key.default)
    }
    
    @IBAction func touchUpSaveButton() {
        UserDefaults.standard.set(toBeSavedTextField.text, forKey: Key.default)
        savedTextLabel.text = UserDefaults.standard.string(forKey: Key.default)
    }
}

private extension UserDefaultsViewController {
    @frozen enum Key {
        static let `default` = "default"
    }
}
