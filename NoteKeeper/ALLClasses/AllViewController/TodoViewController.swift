//
//  TodoViewController.swift
//  NoteKeeper
//
//  Created by developer on 25/03/19.
//  Copyright © 2019 NoteKeeper. All rights reserved.
//

import UIKit
import AMColorPicker

class TodoViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var tbl: UITableView!
    let countofarray:NSMutableArray = NSMutableArray()
    var isedit:Bool = false
    var colorSelected:String = "#ffffff"
    
    
    
    @IBOutlet weak var viw1: UIView!
    @IBOutlet weak var viw2: UIView!
    @IBOutlet weak var viw3: UIView!
    @IBOutlet weak var viw4: UIView!
    @IBOutlet weak var viw5: UIView!
    @IBOutlet weak var viw6: UIView!
    @IBOutlet weak var viw7: UIView!
    @IBOutlet weak var viw8: UIView!
    @IBOutlet weak var viw9: UIView!
    @IBOutlet weak var viw10: UIView!
    
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var txt6: UITextField!
    @IBOutlet weak var txt7: UITextField!
    @IBOutlet weak var txt8: UITextField!
    @IBOutlet weak var txt9: UITextField!
    @IBOutlet weak var txt10: UITextField!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    
    
     var aryView:[UIView] = [UIView]()
    var aryText:[UITextField] = [UITextField]()
    var aryBtn:[UIButton] = [UIButton]()
    var getObject:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TO DO"
        tbl.tableFooterView = UIView()
        
        aryView = [viw1,viw2,viw3,viw4,viw5,viw6,viw7,viw8,viw9,viw10]
        aryText = [txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10]
        aryBtn = [btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10]
        
        for i in 0..<10 {
           countofarray.add(0)
        }
        
        if(self.isedit == false)
        {
            countofarray.removeObject(at: 0)
            countofarray.insert(1, at: 0)
            
        }else
        {
           self.txtTitle.text = getObject.value(forKey: "text") as? String ?? ""
            let getc:String = getObject.value(forKey: "count") as? String ?? "0"
            let getcount:Int = Int(getc) ?? 0
            
            for i in 0..<getcount {
                countofarray.removeObject(at: i)
                countofarray.insert(1, at: i)
            }
            
            
        }
        
       
        
        navigationBar()
        UpdateVIew()
        // Do any additional setup after loading the view.
    }
    
    func navigationBar()
    {
        let btList: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "color-picker"), style: .plain, target: self, action: #selector(self.click_Color))
        
        let btADD: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "addb"), style: .plain, target: self, action: #selector(self.click_Add))
        
        self.navigationItem.rightBarButtonItems  = [btADD,btList]
        
        
    }
    
    func UpdateVIew()
    {
       
        
        for getView in aryView {
            getView.isHidden = true
        }
        if(self.isedit == false)
        {
        
        for i in 0..<countofarray.count {
            
            let getValue:Int = countofarray.object(at: i) as? Int ?? 0
            if(getValue == 1)
            {
             let GetUIview:UIView = aryView[i]
             GetUIview.isHidden = false
            }
        }
            
        }else
        {
            
            for i in 0..<countofarray.count {
                
                let getValue:Int = countofarray.object(at: i) as? Int ?? 0
                if(getValue == 1)
                {
                    let GetUIview:UIView = aryView[i]
                    GetUIview.isHidden = false
                }
            }
            
            
            let getId = getObject.value(forKey: "id") as? String ?? ""
            let aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllTodo(byid:getId)
            
            for i in 0..<aryData.count {
                
                let btn:UIButton = aryBtn[i]
                let lbl:UITextField = aryText[i]
                
                let getObj:NSDictionary = aryData.object(at: i) as! NSDictionary
                let getTitle:String = getObj.value(forKey: "text") as? String ?? ""
                let comp:String = getObj.value(forKey: "com") as? String ?? ""
                lbl.text = getTitle
                if(comp == "0")
                {
                    btn.setImage(UIImage.init(named: "uncheckbox"), for: .normal)
                }else
                {
                    btn.setImage(UIImage.init(named: "check"), for: .normal)
                }
            }
        }
        
    }
    
    @IBAction func click_Color(sender: UIButton)
    {
        let colorPickerViewController = AMColorPickerViewController()
        colorPickerViewController.selectedColor = UIColor.red
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func click_Add(sender: UIButton)
    {
        
        
        
        
        //... befor add new check last one is enter text or not
        var checckObject:Bool = true
        for i in 0..<countofarray.count {
            
            let getValue:Int = countofarray.object(at: i) as? Int ?? 0
            if(getValue == 1)
            {
                let getTextField:UITextField = aryText[i]
                let getText = getTextField.text
                if(getText?.count == 0)
                {
                    checckObject = false
                    break
                }
            }
            
            
        }
        
       if(checckObject == false)
       {
       
        let otherAlert = UIAlertController(title: "OOPS!", message: "Please enter text in Todo list", preferredStyle: UIAlertController.Style.alert)
        
        let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            
        }
        
        // relate actions to controllers
        otherAlert.addAction(printSomething)
        present(otherAlert, animated: true, completion: nil)
        
        return
       }
           
            for i in 0..<countofarray.count {
                
                let getValue:Int = countofarray.object(at: i) as? Int ?? 0
                if(getValue == 0)
                {
                    countofarray.removeObject(at: i)
                    countofarray.insert(1, at: i)
                    break
                }
                
                
            }
           
            UpdateVIew()
    
        
    }
    @IBAction func click_checkbox(sender: UIButton)
    {
        
        if(sender.imageView?.image == UIImage.init(named: "uncheckbox"))
        {
            sender.setImage(UIImage.init(named: "check"), for: .normal)
        }else
        {
            sender.setImage(UIImage.init(named: "uncheckbox"), for: .normal)
        }
    }
    
    @IBAction func click_Delete(sender: UIButton)
    {
        
//        if(self.isedit == false)
//        {
            countofarray.removeObject(at: sender.tag)
            countofarray.insert(0, at: sender.tag)
            
//        }
        
        UpdateVIew()
        
    }
    
    @IBAction func click_Submit(sender: UIButton)
    {
        let getText = self.txtTitle.text as? String ?? ""
        let getFinalText = getText.trimmingCharacters(in: .whitespaces)
        if(getFinalText.count > 0)
        {
            var checckObject:Bool = true
            for i in 0..<countofarray.count {
                
                let getValue:Int = countofarray.object(at: i) as? Int ?? 0
                if(getValue == 1)
                {
                    let getTextField:UITextField = aryText[i]
                    let getText = getTextField.text
                    if(getText?.count == 0)
                    {
                        checckObject = false
                        break
                    }
                }
            }
            
            if(checckObject == false)
            {
                
                let otherAlert = UIAlertController(title: "OOPS!", message: "Please enter text in Todo list", preferredStyle: UIAlertController.Style.alert)
                
                let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                    
                }
                
                // relate actions to controllers
                otherAlert.addAction(printSomething)
                present(otherAlert, animated: true, completion: nil)
                
                return
            }else
            {
                let finalTODoList:NSMutableArray = NSMutableArray()
                for i in 0..<countofarray.count {
                    
                    let getValue:Int = countofarray.object(at: i) as? Int ?? 0
                    if(getValue == 1)
                    {
                        let getTextField:UITextField = aryText[i]
                        let getText = getTextField.text
                        
                        let getBtn:UIButton = aryBtn[i]
                        var isCompleted = "1"
                        if(getBtn.imageView?.image == UIImage.init(named: "uncheckbox"))
                        {
                            isCompleted = "0"
                        }
                        
                        let getDic:NSMutableDictionary = NSMutableDictionary()
                        getDic.setValue(getText, forKey: "text")
                        getDic.setValue(isCompleted, forKey: "comp")
                        finalTODoList.add(getDic)
                    }
                    
                    
                }
                
                
                if(self.isedit == false)
                {
                let getID:Int =  FMDBQueueManager.shareFMDBQueueManager.insertTodo(getTitle: getFinalText, getColor: self.colorSelected )
               // print("get-->",getID)
                
               
                  
                    FMDBQueueManager.shareFMDBQueueManager.InsertTODOLIST(getListOFTODO: finalTODoList, getId: getID)
                }else
                {
                    let getNoteID:String = getObject.value(forKey: "id") as? String ?? ""
                    print("getNoteID",getNoteID)
                    
                    //.. update Title or color of the index   -->  UpdateinsertTodo
                    //.. delete Todo list and insert new one by id -->DeleteToDO
                    FMDBQueueManager.shareFMDBQueueManager.UpdateinsertTodo(getTitle: getFinalText, getColor: self.colorSelected, getid: getNoteID)
                    
                    FMDBQueueManager.shareFMDBQueueManager.DeleteToDO(categoryid: getNoteID)
                    
                    FMDBQueueManager.shareFMDBQueueManager.InsertTODOLIST(getListOFTODO: finalTODoList, getId: Int(getNoteID) ?? 0)
                    
                }
                    self.navigationController?.popViewController(animated: true)
                
            }
            
        }else
        {
            
            let otherAlert = UIAlertController(title: "OOPS!", message: "Please enter title", preferredStyle: UIAlertController.Style.alert)
            
            let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                
            }
            
            // relate actions to controllers
            otherAlert.addAction(printSomething)
            present(otherAlert, animated: true, completion: nil)
            
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // this method get called when you tap "Go"
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nsString = NSString(string: textField.text!)
        let newText = nsString.replacingCharacters(in: range, with: string)
        
        
        if(textField == txtTitle)
        {
            let aSet = NSCharacterSet(charactersIn:"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ. ").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if( string == numberFiltered)
            {
                return true
            }else
            {
                return false
            }
        }
        
        return false
    }
    
}

extension TodoViewController:UITableViewDataSource,UITableViewDelegate
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.countofarray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.txtTitle.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}



extension TodoViewController:AMColorPickerViewControllerDelegate
{
    func colorPickerViewController(colorPickerViewController: AMColorPickerViewController, didSelect color: UIColor) {
        //print(color.htmlRGBaColor)
        colorSelected = color.htmlRGBaColor
        
    }
}
