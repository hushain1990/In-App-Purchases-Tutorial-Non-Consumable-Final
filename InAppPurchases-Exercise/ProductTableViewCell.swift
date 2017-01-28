//
//  ProductTableViewCell.swift
//  InAppPurchases-Exercise
//
//  Created by Jad Habal on 2017-01-23.
//  Copyright © 2017 Jadhabal. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productStatus: CustomButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        productStatus.layer.cornerRadius = 20
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
