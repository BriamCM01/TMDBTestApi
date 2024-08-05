//
//  LoaderView.swift
//  MyMoviesD
//
//  Created by Briam Cano on 04/08/24.
//

import UIKit

public class LoadingView {
    
    var containerView = UIView()
    var progressView = UIView()
//    var activityIndicator = UIActivityIndicatorView()

    
    public class var shared: LoadingView {
        struct Static {
            static let instance: LoadingView = LoadingView()
        }
        return Static.instance
    }
    
    var pinchImageView = UIImageView()
    
    public func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else {
                return
            }
            
            self.containerView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            self.containerView.backgroundColor = .clear
    //        containerView.alpha = 0.8 //UIColorFromHex(rgbValue: 0xffffff, alpha: 0.80)
    //        let imageData = NSData(contentsOf: Bundle.main.url(forResource: "LoaderMobility", withExtension: "gif")!)
            let gifString = "Spinner-2"
        
            DispatchQueue.main.async {
                let animatedImage = UIImage.gifImageWithName(gifString)
                self.pinchImageView.image = animatedImage
            }
             
            self.pinchImageView.frame = CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0)
    //        pinchImageView.center = CGPointMake(30.0, 30.0);
            self.progressView.frame = CGRectMake(0, 0, (self.pinchImageView.frame.size.width), 60)
            self.progressView.center = window.center
            self.progressView.addSubview(self.pinchImageView)
            self.containerView.addSubview(self.progressView)
            window.addSubview(self.containerView)
        }
    }
    
    public func hide() {
//        DispatchQueue.main.async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            self.activityIndicator.stopAnimating()
            self.pinchImageView.removeFromSuperview()
//            self.activityIndicator.removeFromSuperview()
            self.progressView.removeFromSuperview()
            self.containerView.removeFromSuperview()
        }
    }
    
    public func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
