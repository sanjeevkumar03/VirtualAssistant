//
//  ProgressBarView.swift
//  progressBar
//
//  Created by ashika shanthi on 1/4/18.
//  Copyright © 2018 ashika shanthi. All rights reserved.
//

import UIKit
class ProgressBarView: UIView {
    
   var progressLyr = CAShapeLayer()
       var trackLyr = CAShapeLayer()
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.frame.size = CGSize(width: 36, height: 36)
        makeCircularPath()
    }
       required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          makeCircularPath()
       }
       var progressClr = UIColor.white {
          didSet {
             progressLyr.strokeColor = progressClr.cgColor
          }
       }
       var trackClr = UIColor.white {
          didSet {
             trackLyr.strokeColor = trackClr.cgColor
          }
       }
    
    var progress: Float = 0 {
        willSet(newValue)
        {
            print(newValue)
            progressLyr.strokeEnd = CGFloat(newValue)
        }
    }
       func makeCircularPath() {
          self.backgroundColor = UIColor.clear
          self.layer.cornerRadius = self.frame.size.width/2
          let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
          trackLyr.path = circlePath.cgPath
          trackLyr.fillColor = UIColor.clear.cgColor
          trackLyr.strokeColor = trackClr.cgColor
          trackLyr.lineWidth = 2.0
          trackLyr.strokeEnd = 1.0
          layer.addSublayer(trackLyr)
          progressLyr.path = circlePath.cgPath
          progressLyr.fillColor = UIColor.clear.cgColor
          progressLyr.strokeColor = progressClr.cgColor
          progressLyr.lineWidth = 2.0
          progressLyr.strokeEnd = 0.0
          layer.addSublayer(progressLyr)
       }
//       func progress(value: Float) {
//          progressLyr.strokeEnd = CGFloat(value)
//       }
    }
