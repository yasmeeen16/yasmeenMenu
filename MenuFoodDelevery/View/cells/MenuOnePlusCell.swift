//
//  MenuOnePlusCell.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/5/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import UIKit

class MenuOnePlusCell: UITableViewCell {

    @IBOutlet weak var BasecView: UIView!
    @IBOutlet weak var BackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BasecView.dropShadow(scale: false)
        BackView.dropShadow(scale: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
