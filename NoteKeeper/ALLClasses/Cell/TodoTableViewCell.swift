//
//  TodoTableViewCell.swift
//  NoteKeeper
//
//  Created by developer on 25/03/19.
//  Copyright © 2019 NoteKeeper. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnCheckmardk: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
