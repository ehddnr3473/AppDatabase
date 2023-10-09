//
//  CoreDataViewController.swift
//  AppDatabase
//
//  Created by 김동욱 on 10/4/23.
//

import UIKit

final class CoreDataViewController: UIViewController {

    @IBOutlet weak var toBeSavedTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    private var histories = [TestHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    @IBAction func touchUpSaveButton() {
        do {
            try CoreDataUtil.saveHistory(TestHistory(text: toBeSavedTextField.text ?? "", date: Date()))
            fetch()
        } catch {
            
        }
    }
}

private extension CoreDataViewController {
    func fetch() {
        do {
            histories = try CoreDataUtil.fetchHistory()
            
            DispatchQueue.main.async {
                self.historyTableView.reloadData()
            }
        } catch {
            
        }
    }
}

extension CoreDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        
        cell.textLabel?.text = "Text: \(histories[indexPath.row].text) Date: \(histories[indexPath.row].date.description)"
        
        return cell
    }
}
