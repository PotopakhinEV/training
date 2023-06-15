//
//  WeatherCellTableViewCell.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 15.06.2023.
//

import UIKit

class WeatherCellTableViewCell: UITableViewCell {

    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    @IBOutlet weak var dateTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configure(weather: Conditions) {
        self.dateTime.text = weather.datetime
        self.weather.text = String(format: "%.1f", weather.temp.FtoCConvert())
        self.conditionIcon.image = UIImage(named: weather.icon)
    }
}
