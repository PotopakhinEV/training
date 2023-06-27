//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 15.06.2023.
//

import UIKit

class WeatherDetailView: UIView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var contentView: WeatherDetailView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func commonInit() {
        Bundle.main.loadNibNamed("WeatherDetailView", owner: self, options: nil)
        contentView.fixInView(self)
    }
}
