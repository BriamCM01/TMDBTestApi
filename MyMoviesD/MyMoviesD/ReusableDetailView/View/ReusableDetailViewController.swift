//
//  ReusableDetailViewController.swift
//  MyMoviesD
//
//  Created by Briam Cano on 03/08/24.
//

import UIKit
import SDWebImage

class ReusableDetailViewController: UIViewController {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    
    
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgMovie.sd_setImage(with: URL(string: viewModel.detailMovie.poster), placeholderImage: UIImage.placeholderError)
        lblTitle.text = viewModel.detailMovie.title
        textViewDescription.text = viewModel.detailMovie.description
        guard let date = dateFromISOString(viewModel.detailMovie.date) else {return}
        let dateFormattter = DateFormatter()
        dateFormattter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormattter.string(from: date)
        lblDate.text = "Fecha de lanzamiento: \(dateString)"
        setupView()
        
    }
    private func setupView() {
        lblLink.isUserInteractionEnabled = true
        let linkCustomAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.appColor900,
            NSAttributedString.Key.underlineColor: UIColor.appColor900,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        lblLink.attributedText = NSAttributedString(string: "Mas información...", attributes: linkCustomAttributes)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewMoreInfo))
        lblLink.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewMoreInfo(_ gesture: UITapGestureRecognizer) {
        let web = ReusableWebViewController.init(url: viewModel.detailMovie.poster)
        self.present(web, animated: true)
        
    }
    
    func setupViewModel(_ viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func dateFromISOString(_ isoString: String) -> Date? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]  // ignores time!
        return isoDateFormatter.date(from: isoString)  // returns nil, if isoString is malformed.
    }
}
