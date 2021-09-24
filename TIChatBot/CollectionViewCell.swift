//
//  CollectionViewCell.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 17/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import UIKit



class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var optionsArray:[Option]?
    var settings:Setting?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.optionsTableView.delegate = self 
        self.optionsTableView.dataSource = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
           imgView.isUserInteractionEnabled = true
           imgView.addGestureRecognizer(tapGestureRecognizer)
        
        optionsTableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")

        // self.collectionView.register(UINib.init(nibName: “CollectionViewCell”, bundle: nil), forCellWithReuseIdentifier: “collectionViewID”)
      //  self.optionsTableView.register(UINib(nibName:"OptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptionCollectionViewCell")
        // Initialization code
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: tappedImage.image)
        print("image Tapped")

    }
    
    func configureCell(carouselObj:CarousalObject) {
        print(carouselObj.text)
        print("\(carouselObj.text)===\(carouselObj.options.count)")
        self.optionsArray = carouselObj.options
        let tblViewHeight = CGFloat(self.optionsArray!.count * 40)
        optionsTableView.backgroundColor = .clear
        tableViewHeightConstraint.constant = tblViewHeight
        
        
       // optionsTableView.heightAnchor.constraint(equalToConstant: tblViewHeight).isActive = true
        //self.optionsTableView.heightAnchor.constraint(equalTo: tblViewHeight).isActive = true
       // print("\( self.optionsArray?.count)====\(carouselObj.options.count)")

        
        self.titleLbl.text = carouselObj.text
          print("self.titleLbl.text ====== \(self.titleLbl.text)")
        self.imgView.image = UIImage(named: "Image")!

        if carouselObj.image != nil && carouselObj.image != ""{
        downloadImage(from: URL(string: carouselObj.image)!)
        }
    }
    
//    var carouselObj:CarousalObject!{
//        didSet{
//            
//        }
//    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription)
                return
                
            }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imgView.image = UIImage(data: data)
            }
        }
    }

}

extension CollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
        cell.configureCell(option: optionsArray![indexPath.row], settings: settings!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.optionsArray?.count ?? 0
     }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38.0
    }

//
//
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return  self.optionsArray?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
//
//        //in this example I added a label named "title" into the MyCollectionCell class
//        print(self.optionsArray![indexPath.item].label)
//        //  cell.titleLbl.text = self.caraouselObjArray![indexPath.item].text
//        cell.configureCell(option: self.optionsArray![indexPath.item])
//        // cell.carouselObj = self.caraouselObjArray![indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // handle tap events
//        print("You selected cell #\(indexPath.item)!")
//    }
//
//    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    //        return CGSize(width: 250, height: 300)
//    //    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let frameSize = collectionView.frame.size
//        print(frameSize.height)
//        return CGSize(width: frameSize.width - 10, height: frameSize.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//    }
//
}
