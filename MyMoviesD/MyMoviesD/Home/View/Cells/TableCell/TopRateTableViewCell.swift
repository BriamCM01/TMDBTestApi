//
//  TopRateTableViewCell.swift
//  MyMoviesD
//
//  Created by Briam Cano on 04/08/24.
//

import UIKit
import SDWebImage

class TopRateTableViewCell: UITableViewCell {
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textViewOverview: UITextView!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .appColor700
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        imgPoster.image = nil
        lblTitle.text = nil
        textViewOverview.text = nil
        lblDate.text = nil
    }
    
    func setupTableCell(poster: String, title: String, overview: String, date: String) {
        self.imgPoster.sd_setImage(with: URL(string: poster), placeholderImage: UIImage.placeholderError)
        self.lblTitle.text = title
        self.textViewOverview.text = overview
        
        guard let date = dateFromISOString(date) else {return}
        let dateFormattter = DateFormatter()
        dateFormattter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormattter.string(from: date)
        lblDate.text = "Fecha de lanzamiento: \(dateString)"
    }
    
    func dateFromISOString(_ isoString: String) -> Date? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]  // ignores time!
        return isoDateFormatter.date(from: isoString)  // returns nil, if isoString is malformed.
    }
    
}
