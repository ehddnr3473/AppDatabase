//
//  FileSystemViewController.swift
//  AppDatabase
//
//  Created by 김동욱 on 10/4/23.
//

import UIKit

final class FileSystemViewController: UIViewController {

    @IBOutlet weak var writeFileNameTextField: UITextField!
    @IBOutlet weak var toBeSavedTextField: UITextField!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var toBeReadLabel: UILabel!
    @IBOutlet weak var readFileNameTextField: UITextField!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var toBeDeletedTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    private let fileSystemUtil = FileSystemUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpWriteButton() {
        guard let fileName = writeFileNameTextField.text,
              let text = toBeSavedTextField.text,
              fileName != "",
              text != "" else { return }
        
        fileSystemUtil.write(fileName, text)
        writeFileNameTextField.text = ""
        toBeSavedTextField.text = ""
    }
    
    @IBAction func touchUpReadButton() {
        guard let fileName = readFileNameTextField.text else { return }
        
        if let readText = fileSystemUtil.read(fileName) {
            toBeReadLabel.text = readText
        } else {
            toBeReadLabel.text = "파일을 찾을 수 없습니다."
        }
    }
    
    @IBAction func touchUpDeleteButton() {
        guard let fileName = toBeDeletedTextField.text else { return }
        
        fileSystemUtil.delete(fileName)
        toBeDeletedTextField.text = ""
    }
}
