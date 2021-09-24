//
//  ImageViewController.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 14/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageViewController: UIViewController, UIScrollViewDelegate {
 @IBOutlet weak var imageView: UIImageView!
 @IBOutlet weak var scrolView: UIScrollView!
 @IBOutlet weak var cancel: UIButton!
    
 var tap:UITapGestureRecognizer!

    @IBOutlet weak var imgViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewTopCnstraint: NSLayoutConstraint!
    var imgUrl:String?
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
               scrolView.delegate = self
               scrolView.minimumZoomScale = 1.0
               scrolView.maximumZoomScale = 10.0
               addSingleTapGestureInImage()
               setImage()
    }
    
    func setImage() {
        if let imageUrl = imgUrl{
            imageView.af_setImage(withURL:URL(string: imageUrl)!)
        }
        else{
            if let img = image{
                imageView.image = img
            }
        }
    }
    
    
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                return imageView
            }
    
    func addSingleTapGestureInImage() {
        tap = UITapGestureRecognizer(target: self, action: #selector(ImageViewController.handleTap(_:)))
        tap.numberOfTapsRequired = 1;

        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        imgViewBottomConstraint.constant = imgViewBottomConstraint.constant == 70 ? 0:70
//        imgViewTopCnstraint.constant = imgViewTopCnstraint.constant == 70 ? 0:70
//        cancel.isHidden = !cancel.isHidden
    }
    
}
