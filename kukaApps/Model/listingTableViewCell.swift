//
//  listingTableViewCell.swift
//  kukaApps
//
//  Created by Yusuf Burak Elkan on 27.04.2022.
//

import UIKit

class listingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var point: UILabel!
    
    var indexPath:IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
