//
//  View.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 21.05.2023.
//

import UIKit

class MainView: UIView {

    private var vc: MainViewVC!

    @IBOutlet var contentView: MainView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!

    @IBAction func selectCity(_ sender: UIBarButtonItem) {
        vc.showAlertVC()
    }

    func setVC(vc: MainViewVC) {
        self.vc = vc
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("MainView", owner: self, options: nil)
        contentView.fixInView(self)
    }
}

protocol MainViewVC {
    func showAlertVC()
}

extension UIView {
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }

}

