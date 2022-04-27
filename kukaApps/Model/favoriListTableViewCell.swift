//
//  favoriListTableViewCell.swift
//  kukaApps
//
//  Created by Yusuf Burak Elkan on 27.04.2022.
//

import UIKit

class favoriListTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriName: UILabel!
    @IBOutlet weak var favoriPoint: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var indexPath:IndexPath?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
