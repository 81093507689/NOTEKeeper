//
//  NotesViewController.swift
//  NoteKeeper
//
//  Created by developer on 25/03/19.
//  Copyright © 2019 NoteKeeper. All rights reserved.
//

import UIKit
import AMColorPicker

class NotesViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDetail: UITextField!
    var colorSelected:String = "#ffffff"
    var isedit:Bool = false
    var getObject:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        navigationBar()
        if(isedit == true)
        {
            txtTitle.text = getObject.value(forKey: "text") as? String ?? ""
            txtDetail.text = getObject.value(forKey: "detail") as? String ?? ""
            colorSelected = getObject.value(forKey: "color") as? String ?? ""
        }
    }
    
    func navigationBar()
    {
        let btList: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "color-picker"), style: .plain, target: self, action: #selector(self.click_Color))
        
        
        self.navigationItem.rightBarButtonItem  = btList
        
        
    }
    
    
    @IBAction func click_Color(sender: UIButton)
    {
        let colorPickerViewController = AMColorPickerViewController()
        colorPickerViewController.selectedColor = UIColor.red
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func click_Submit(sender: UIButton)
    {
        let getText = self.txtTitle.text as? String ?? ""
        let getFinalText = getText.trimmingCharacters(in: .whitespaces)
        if(getFinalText.count > 0)
        {
            let getDetail = self.txtDetail.text as? String ?? ""
            let getFinalDetail = getDetail.trimmingCharacters(in: .whitespaces)
            if(getFinalDetail.count > 0)
            {
                if(isedit == true)
                {
                    let getID:String = getObject.value(forKey: "id") as? String ?? ""
                    FMDBQueueManager.shareFMDBQueueManager.UpdateNotes(getTitle: getFinalText, getDetail: getFinalDetail, getColor: self.colorSelected, getid: getID)
                }else
                {
                let getID = FMDBQueueManager.shareFMDBQueueManager.insertNOTE(getTitle: getFinalText, getDetail: getFinalDetail, getType: "0", getColor: self.colorSelected)
                }
                self.navigationController?.popViewController(animated: true)
                
            }else
            {
                
                let otherAlert = UIAlertController(title: "OOPS!", message: "Please enter detail", preferredStyle: UIAlertController.Style.alert)
                
                let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                    
                }
                
                // relate actions to controllers
                otherAlert.addAction(printSomething)
                present(otherAlert, animated: true, completion: nil)
                
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
        
        
        if(textField == txtTitle || textField == txtDetail)
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



extension NotesViewController:AMColorPickerViewControllerDelegate
{
    func colorPickerViewController(colorPickerViewController: AMColorPickerViewController, didSelect color: UIColor) {
        //print(color.htmlRGBaColor)
         colorSelected = color.htmlRGBaColor
        
    }
}



extension UIColor {
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0,0,0,0)
    }
    // hue, saturation, brightness and alpha components from UIColor**
    var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
            return (hue,saturation,brightness,alpha)
        }
        return (0,0,0,0)
    }
    var htmlRGBColor:String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
    }
    var htmlRGBaColor:String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255),Int(rgbComponents.alpha * 255) )
    }
}



extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
