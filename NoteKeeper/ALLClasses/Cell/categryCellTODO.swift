//
//  categryCellTODO.swift
//  NoteKeeper
//
//  Created by developer on 26/03/19.
//  Copyright © 2019 NoteKeeper. All rights reserved.
//

import UIKit

class categryCellTODO: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viw: UIView!
    var getId:String = ""
    
    
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
    
    
    @IBOutlet weak var txt1: UILabel!
    @IBOutlet weak var txt2: UILabel!
    @IBOutlet weak var txt3: UILabel!
    @IBOutlet weak var txt4: UILabel!
    @IBOutlet weak var txt5: UILabel!
    @IBOutlet weak var txt6: UILabel!
    @IBOutlet weak var txt7: UILabel!
    @IBOutlet weak var txt8: UILabel!
    @IBOutlet weak var txt9: UILabel!
    @IBOutlet weak var txt10: UILabel!
    
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
    var aryText:[UILabel] = [UILabel]()
    var aryBtn:[UIButton] = [UIButton]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aryView = [viw1,viw2,viw3,viw4,viw5,viw6,viw7,viw8,viw9,viw10]
        aryText = [txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10]
        aryBtn = [btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10]
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // HideAllView()
//        for getV in aryView {
//            getV.isHidden = true
//        }
//     let aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllTodo(byid: getId)
//        print(aryData)
//        for i in 0..<aryData.count {
//            let v:UIView = aryView[i]
//            let btn:UIButton = aryBtn[i]
//            let lbl:UILabel = aryText[i]
//            v.isHidden = false
//            let getObj:NSDictionary = aryData.object(at: i) as! NSDictionary
//            let getTitle:String = getObj.value(forKey: "text") as? String ?? ""
//            let comp:String = getObj.value(forKey: "com") as? String ?? ""
//            lbl.text = getTitle
//            if(comp == "0")
//            {
//                btn.setImage(UIImage.init(named: "uncheckbox"), for: .normal)
//            }else
//            {
//                btn.setImage(UIImage.init(named: "check"), for: .normal)
//            }
//        }
        
        // Configure the view for the selected state
    }
    
    func HideAllView()
    {
        for getV in aryView {
            getV.isHidden = true
        }
    }

}
