//
//  ViewController.swift
//  NoteKeeper
//
//  Created by developer on 25/03/19.
//  Copyright © 2019 NoteKeeper. All rights reserved.
//

import UIKit
import JJFloatingActionButton




class ViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    var aryData: NSMutableArray = NSMutableArray()
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var viwNorecord: UIView!
    let actionButton = JJFloatingActionButton()
    
     var btList: UIBarButtonItem!
     var btOrder: UIBarButtonItem!
    var listorcollection:Int = 0  // 0 - list , 1 for collection
    var asdANDDesc:Int = 0  // 0 - asc , 1 for desc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.tableFooterView = UIView()
        tbl.estimatedRowHeight = 44.0
        self.tbl.rowHeight = UITableView.automaticDimension
        
        self.title = "NoteKeeper"
        navigationBar()
        FloatingButton()
        
       // let snCollectionViewLayout = SNCollectionViewLayout()
        //snCollectionViewLayout.fixedDivisionCount = 4 // Columns for .vertical, rows for .horizontal
       // snCollectionViewLayout.delegate = self
       // myCollectionView.collectionViewLayout = snCollectionViewLayout
        myCollectionView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllCategory(getOrderBy:"ASC")
        //print(aryData)
        if(aryData.count > 0)
        {
           viwNorecord.isHidden = true
        }else
        {
            viwNorecord.isHidden = false
        }
        tbl.reloadData()
        myCollectionView.reloadData()
    }

    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    func navigationBar()
    {
        btList = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(self.click_Setting))
        btOrder = UIBarButtonItem(image: UIImage(named: "uarrow"), style: .plain, target: self, action: #selector(self.click_Order))
        
        
        self.navigationItem.rightBarButtonItems  = [btList,btOrder]
        
        
    }
    
    
    @IBAction func click_Setting(sender: UIButton)
    {
       
        if(listorcollection == 0)
        {
            listorcollection = 1
        }else
        {
            listorcollection = 0
        }
        
        updateListButton()
    }
    
    @IBAction func click_Order(sender: UIButton)
    {
        if(asdANDDesc == 0)
        {
            asdANDDesc = 1
        }else
        {
            asdANDDesc = 0
        }
        
        updateOrderButton()
    }
    
    
    func updateListButton()
    {
        if(listorcollection == 0)
        {
            btList = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(self.click_Setting))
            myCollectionView.isHidden = true
            tbl.isHidden = false
        }else
        {
            btList = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.click_Setting))
            myCollectionView.isHidden = false
            tbl.isHidden = true
        }
        
        self.navigationItem.rightBarButtonItems  = [btList,btOrder]
    }
    
    func updateOrderButton()
    {
        if(asdANDDesc == 0)
        {
             btOrder = UIBarButtonItem(image: UIImage(named: "uarrow"), style: .plain, target: self, action: #selector(self.click_Order))
            aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllCategory(getOrderBy:"ASC")
        }else
        {
             btOrder = UIBarButtonItem(image: UIImage(named: "darrow"), style: .plain, target: self, action: #selector(self.click_Order))
            aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllCategory(getOrderBy:"DESC")
        }
        
        self.navigationItem.rightBarButtonItems  = [btList,btOrder]
        self.tbl.reloadData()
        self.myCollectionView.reloadData()
    }
    
     func FloatingButton()
     {
        
       let mainStory : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        actionButton.addItem(title: "Make ToDo", image: #imageLiteral(resourceName: "todo")) { item in
            
            
            let viewController:TodoViewController = mainStory.instantiateViewController(withIdentifier: "TodoViewController") as! TodoViewController
           
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        actionButton.addItem(title: "Make Notes", image:#imageLiteral(resourceName: "addnotes")) { item in
            
            
            let viewController:NotesViewController = mainStory.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        

        
        actionButton.display(inViewController: self)
       
    }

}



extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.aryData.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let getObje = aryData.object(at: indexPath.row) as! NSDictionary
        let getType:String = getObje.value(forKey: "type") as? String ?? ""
        if(getType == "0")
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
       
        
        cell.lblTitle.text = getObje.value(forKey: "text") as? String ?? ""
        
        let getDate:String = getObje.value(forKey: "dt") as? String ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let getFinalDate = dateFormatter.date(from: getDate)
        dateFormatter.dateFormat = "dd/MMMM/yyyy"
        let getdateINString = dateFormatter.string(from: getFinalDate!)
        
        cell.lblDate.text = getdateINString
        
        cell.lblDetail.text = getObje.value(forKey: "detail") as? String ?? ""
        let getC:String = getObje.value(forKey: "color") as? String ?? ""
        if(getC.count > 0)
        {
        let getcolor:UIColor = UIColor(hexString: getC)
            cell.viw.backgroundColor = getcolor
        }
        cell.viw.layer.cornerRadius = 8
        
        
        
        
        cell.selectionStyle = .none
        return cell
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categryCellTODO", for: indexPath) as! categryCellTODO
            
            
            
            cell.lblTitle.text = getObje.value(forKey: "text") as? String ?? ""
            
            let getDate:String = getObje.value(forKey: "dt") as? String ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let getFinalDate = dateFormatter.date(from: getDate)
            dateFormatter.dateFormat = "dd/MMMM/yyyy HH:mm"
            let getdateINString = dateFormatter.string(from: getFinalDate!)
            
            cell.lblDate.text = getdateINString
            let getC:String = getObje.value(forKey: "color") as? String ?? ""
            if(getC.count > 0)
            {
                let getcolor:UIColor = UIColor(hexString: getC)
                cell.viw.backgroundColor = getcolor
            }
            cell.viw.layer.cornerRadius = 8
            
            
            cell.getId = getObje.value(forKey: "id") as? String ?? ""
            
            let getc:String = getObje.value(forKey: "count") as? String ?? "0"
            let getcount:Int = Int(getc) ?? 0
            
            var aryView:[UIView] = [cell.viw1,cell.viw2,cell.viw3,cell.viw4,cell.viw5,cell.viw6,cell.viw7,cell.viw8,cell.viw9,cell.viw10]
            var aryText:[UILabel] = [cell.txt1,cell.txt2,cell.txt3,cell.txt4,cell.txt5,cell.txt6,cell.txt7,cell.txt8,cell.txt9,cell.txt10]
            var aryBtn:[UIButton] = [cell.btn1,cell.btn2,cell.btn3,cell.btn4,cell.btn5,cell.btn6,cell.btn7,cell.btn8,cell.btn9,cell.btn10]
            
            for getV in aryView {
                getV.isHidden = true
            }
            for i in 0..<getcount {
                let v:UIView = aryView[i]
                v.isHidden = false
            }
            
            let aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllTodo(byid:cell.getId)
        
            for i in 0..<aryData.count {
                
                let btn:UIButton = aryBtn[i]
                let lbl:UILabel = aryText[i]
                
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
            
            
            
            
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStory : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let getObje = aryData.object(at: indexPath.row) as! NSDictionary
        let getType:String = getObje.value(forKey: "type") as? String ?? ""
        if(getType == "0")
        {
            
            let viewController:NotesViewController = mainStory.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
            viewController.isedit = true
            viewController.getObject = getObje
            self.navigationController?.pushViewController(viewController, animated: true)
        }else
        {
            let viewController:TodoViewController = mainStory.instantiateViewController(withIdentifier: "TodoViewController") as! TodoViewController
            viewController.isedit = true
            viewController.getObject = getObje
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.aryData.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2-10, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
    
    let getObje = aryData.object(at: indexPath.row) as! NSDictionary
    let getType:String = getObje.value(forKey: "type") as? String ?? ""
    if(getType == "0")
    {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
    
    
    cell.lblTitle.text = getObje.value(forKey: "text") as? String ?? ""
    
    let getDate:String = getObje.value(forKey: "dt") as? String ?? ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let getFinalDate = dateFormatter.date(from: getDate)
    dateFormatter.dateFormat = "dd/MMMM/yyyy"
    let getdateINString = dateFormatter.string(from: getFinalDate!)
    
    cell.lblDate.text = getdateINString
    
    cell.lblDetail.text = getObje.value(forKey: "detail") as? String ?? ""
    let getC:String = getObje.value(forKey: "color") as? String ?? ""
    if(getC.count > 0)
    {
    let getcolor:UIColor = UIColor(hexString: getC)
    cell.viw.backgroundColor = getcolor
    }
    cell.viw.layer.cornerRadius = 8
    
    
    
    
   // cell.selectionStyle = .none
    return cell
    }else
    {
  
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categryCollectionViewCellTODO", for: indexPath) as! categryCollectionViewCellTODO
        
    
    
    cell.lblTitle.text = getObje.value(forKey: "text") as? String ?? ""
    
    let getDate:String = getObje.value(forKey: "dt") as? String ?? ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let getFinalDate = dateFormatter.date(from: getDate)
    dateFormatter.dateFormat = "dd/MMMM/yyyy HH:mm"
    let getdateINString = dateFormatter.string(from: getFinalDate!)
    
    cell.lblDate.text = getdateINString
    let getC:String = getObje.value(forKey: "color") as? String ?? ""
    if(getC.count > 0)
    {
    let getcolor:UIColor = UIColor(hexString: getC)
    cell.viw.backgroundColor = getcolor
    }
    cell.viw.layer.cornerRadius = 8
    
    
    cell.getId = getObje.value(forKey: "id") as? String ?? ""
    
    let getc:String = getObje.value(forKey: "count") as? String ?? "0"
    let getcount:Int = Int(getc) ?? 0
    
    var aryView:[UIView] = [cell.viw1,cell.viw2,cell.viw3,cell.viw4,cell.viw5,cell.viw6,cell.viw7,cell.viw8,cell.viw9,cell.viw10]
    var aryText:[UILabel] = [cell.txt1,cell.txt2,cell.txt3,cell.txt4,cell.txt5,cell.txt6,cell.txt7,cell.txt8,cell.txt9,cell.txt10]
    var aryBtn:[UIButton] = [cell.btn1,cell.btn2,cell.btn3,cell.btn4,cell.btn5,cell.btn6,cell.btn7,cell.btn8,cell.btn9,cell.btn10]
    
    for getV in aryView {
    getV.isHidden = true
    }
    for i in 0..<getcount {
    let v:UIView = aryView[i]
    v.isHidden = false
    }
    
    let aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllTodo(byid:cell.getId)
    
    for i in 0..<aryData.count {
    
    let btn:UIButton = aryBtn[i]
    let lbl:UILabel = aryText[i]
    
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
    
    
    
    
    
   // cell.selectionStyle = .none
    return cell
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let mainStory : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let getObje = aryData.object(at: indexPath.row) as! NSDictionary
        let getType:String = getObje.value(forKey: "type") as? String ?? ""
        if(getType == "0")
        {
            
            let viewController:NotesViewController = mainStory.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
            viewController.isedit = true
            viewController.getObject = getObje
            self.navigationController?.pushViewController(viewController, animated: true)
        }else
        {
            let viewController:TodoViewController = mainStory.instantiateViewController(withIdentifier: "TodoViewController") as! TodoViewController
            viewController.isedit = true
            viewController.getObject = getObje
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}


//
//extension ViewController: SNCollectionViewLayoutDelegate {
//    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {
//        if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 10 || indexPath.row == 70 {
//
//            return 2
//        }
//        return 1
//    }
//
//
//
//
//}
