//
//  MemoView.swift
//  SimpleMemoApp
//
//  Created by Saga on 2021/02/02.
//

import UIKit

class MemoView: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        textField.text = ""
        
        if let saveMemo = UserDefaults.standard.object(forKey: "memo")   {
            
            textArray = saveMemo as! [String]
        }
        
        /*if let _ = UserDefaults.standard.object(forKey: "memo")  {
            
            textArray = UserDefaults.standard.array(forKey: "memo") as! [String]
        }*/
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //セル構築の際に必要
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = textArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.size.height/12
    }
    
    //右から左へスワイプして削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.textArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    //キーボードでReturnキーを押した際に発動するメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textArrayに追加(append)する <- textField.textを
        textArray.append(textField.text!)
        let valueToSave = textArray
        UserDefaults.standard.setValue(valueToSave, forKey: "memo")
        print(valueToSave)
        //キーボードを閉じる
        textField.resignFirstResponder()
        //textFieldを空にする
        textField.text = ""
        tableView.reloadData()
        
        return true
    }
    
    
}
