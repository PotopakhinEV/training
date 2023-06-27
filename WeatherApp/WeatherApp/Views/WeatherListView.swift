//
//  View.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 21.05.2023.
//

import UIKit

protocol WeatherListViewDelegate: AnyObject {
    func showAlertVC()
}

class WeatherListView: UIView {

    weak var viewDelegate: WeatherListViewDelegate?

    @IBOutlet var contentView: WeatherListView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!

    @IBAction func selectCity(_ sender: UIBarButtonItem) {
        viewDelegate?.showAlertVC()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("WeatherListView", owner: self, options: nil)
        contentView.fixInView(self)
    }
}
