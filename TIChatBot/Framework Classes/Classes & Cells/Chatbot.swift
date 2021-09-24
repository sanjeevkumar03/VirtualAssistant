//
//  chatbot.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 24/07/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import Foundation
import UIKit

public class Chatbot {
    
    public static func initWith(botId:String, serverEndPoint:String, port:String ) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: BasicExampleViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "BasicExampleViewController")
        return vc
    }
    
}
