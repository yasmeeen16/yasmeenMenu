//
//  Home.swift
//  MenuFoodDelevery
//
//  Created by Atiaf on 12/5/19.
//  Copyright © 2019 Atiaf. All rights reserved.
//

import UIKit

class Home: UIViewController {
    private var selectedIndex = 1{
        didSet {
            self.TbleView.reloadData()
        }
    }
    @IBOutlet private weak var deliveryLocationView: UIView!
    @IBOutlet private weak var deliveryLocationLbl: UILabel!
    @IBOutlet private weak var menuplusSelectorView: UIView!
    @IBOutlet private weak var productiveFamilySelectorView: UIView!
    @IBOutlet private weak var categorySelectorView: UIView!
    @IBOutlet weak var TbleView: UITableView!
    @IBOutlet private weak var restaurantsCountLbl: UILabel!
    @IBOutlet private weak var restaurantsCountView: UIView!
    @IBOutlet private weak var filterBtn: UIButton!
    @IBOutlet weak var Restauranrbtn: UIButton!
    @IBOutlet weak var ProductiveFamily: UIButton!
    @IBOutlet weak var MenuOnePlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func RestaurantBtn(_ sender: Any) {
        selectedIndex = 1
        self.Restauranrbtn.setTitleColor(#colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1), for: .normal)
        self.ProductiveFamily.setTitleColor(#colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1), for: .normal)
        self.MenuOnePlus.setTitleColor(#colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1), for: .normal)
        self.categorySelectorView.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1)
        self.productiveFamilySelectorView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.menuplusSelectorView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //        restaurantsLbl.textColor = R.color.primaryColor()
//        productiveFamiliesLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1)
//        menuOnePlusLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1)
//        moveSelector(toView: recognizer.view!)
//        viewModel.getRestaurants()
//        restaurantsCountView.isHidden = false
//        restaurantsCountViewHeight.constant = 40
        
    }
    
    @IBAction func familyBtn(_ sender: Any) {
        selectedIndex = 2
        self.ProductiveFamily.setTitleColor(#colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1), for: .normal)
        self.Restauranrbtn.setTitleColor(#colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1), for: .normal)
        self.MenuOnePlus.setTitleColor(#colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1), for: .normal)
        
        self.categorySelectorView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.productiveFamilySelectorView.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1)
        self.menuplusSelectorView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    @IBAction func menuOneBlusBtn(_ sender: Any) {
        selectedIndex = 3
        self.MenuOnePlus.setTitleColor(#colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1), for: .normal)
        self.Restauranrbtn.setTitleColor(#colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1), for: .normal)
        self.ProductiveFamily.setTitleColor(#colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1), for: .normal)
        
        self.categorySelectorView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.productiveFamilySelectorView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.menuplusSelectorView.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1)
    }
}

extension Home: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 1{
            return 1
        }else if selectedIndex == 2{
            return 2
        }else{
            return 3
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellM", for: indexPath) as! MenuOnePlusCell
        //cell.clinicName.text = cilnicDAO.Clinics[indexPath.row].name
        return cell
    }
    
    
    
}
