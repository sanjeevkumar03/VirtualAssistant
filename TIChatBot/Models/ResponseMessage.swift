//
//  ResponseMessage.swift
//  ChatBoatDemoApp
//
//  Created by Ajeet Sharma on 20/05/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import Foundation




//struct MessageData : Codable {
//    let content:Content?
//}
//
//struct Content : Codable {
//    let response_list:[Response]?
//}
//
//struct Response {
//   let delay:Int?
//   let response:Int?
//   let response_type:String?
//}

struct MessageData {
    var botId:Int?
    var context_life_span:Int?
    var contexts:[Dictionary<String, Any>]?
    var feedback:Dictionary<String, Bool>?
    var context_id:Int?
    var user_message_id:Int?
    var is_prompt:Int?
    var sentiment:Int?
    var responseList:[Response] = []
    var user_session_id:String?
    var user_details:Dictionary<String, Any>?
    var intent_name:String?
    var query:String?
    var reply_index:Int?
    var user_prompt:Dictionary<String, Any>?
    var intent:Int?
    var masked:Int?
    var classified:Int?
    var encrypted:Int?
    var encryption_key:String?

    
    init(mesageData:NSDictionary) {
        
        print(mesageData)
        
        
        if mesageData["intent_name"] != nil{
                   intent_name = (mesageData["intent_name"] as! String)
               }
        if mesageData["masked"] != nil{
            masked = (mesageData["masked"] as! Int)
        }
        if mesageData["encrypted"] != nil{
            encrypted = (mesageData["encrypted"] as! Int)
        }
        if mesageData["encryption_key"] != nil{
            encryption_key = mesageData["encryption_key"] as? String
        }
        
        if mesageData["classified"] != nil{
            classified = (mesageData["classified"] as! Int)
        }
//        if let dict = mesageData["query"] {
//                   query = (mesageData["query"] as! String)
//               }
        if mesageData["reply_index"] != nil{
                   reply_index = (mesageData["reply_index"] as! Int)
               }
        if mesageData["user_prompt"] != nil{
                   user_prompt = (mesageData["user_prompt"] as! Dictionary<String, Any>)
               }
        if mesageData["intent"] != nil{
                   intent = (mesageData["intent"] as! Int)
               }

        if mesageData["context_id"] != nil{
            context_id = (mesageData["context_id"] as! Int)
        }
        if mesageData["user_message_id"] != nil{
            if mesageData["user_message_id"] is NSNull{
                context_life_span = 0
            }
            else{
                user_message_id = mesageData["user_message_id"] as? Int
            }
        }
        if mesageData["sentiment"] != nil{
            sentiment = (mesageData["sentiment"] as! Int)
        }
        if mesageData["Bot_Id"] != nil{
            botId = (mesageData["Bot_Id"] as! Int)
        }
        if mesageData["context_life_span"] != nil {
            if mesageData["context_life_span"] is NSNull{
                context_life_span = 0
            }
            else{
                context_life_span = (mesageData["context_life_span"] as! Int)
            }
        }
        if mesageData["contexts"] != nil{
            contexts = (mesageData["contexts"] as! [Dictionary<String, Any>])
        }
        if mesageData["feedback"] != nil{
            feedback = (mesageData["feedback"] as! Dictionary<String, Bool>)
        }
        if mesageData["is_prompt"] != nil{
            is_prompt = (mesageData["is_prompt"] as! Int)
        }
        if mesageData["user_session_id"] != nil{
            user_session_id = mesageData["user_session_id"] as? String
        }
        if mesageData["response_list"] != nil{
            for response in mesageData["response_list"] as! [NSDictionary]{
                //            let res = Response(response)
                //            print(res)                //

                responseList.append(Response(response))
                print(responseList.count)
            }
        }
    }
}


struct Response {

   // let delay:Int
    var quickReplyArray:[QuickReply] = []
    var carousalArray:[Carousal] = []
    var stringArray:[String]?
    let responseType:String
    var text:String = ""
    var prop:Prop?
    var multiOps:MultiOps?

    init(_ dictionary: NSDictionary) {
      //  self.delay = dictionary["delay"] as! Int
        self.responseType = dictionary["response_type"] as! String
        
        if self.responseType == "text" || self.responseType == "image" || self.responseType == "url" || self.responseType == "video" {
            self.stringArray = dictionary["response"] as? [String]
        }
            
        else if self.responseType == "quick_reply" {
            self.text = dictionary["text"] as? String ?? ""
            for quickReply in dictionary["response"] as! [NSDictionary]{
                self.quickReplyArray.append(QuickReply(quickReply))
            }
        }
            
        else if self.responseType == "props" {
            self.prop = Prop(dictionary["response"] as! NSDictionary)
        }
            
        else if self.responseType == "carousel" {
            self.carousalArray.append(Carousal(dictionary["response"] as! [NSDictionary]))
            print(self.carousalArray)
        }
        
        else if self.responseType == "multi_ops" {
                 multiOps = MultiOps(dictionary["response"] as! NSDictionary)
               }
    }
}



struct MultiOps {
    var choices:[Choice] = []
    var options:[Option] = []
  //  let options_limit:Int
    let text:String
    let valid_retry:Int
   
    init(_ dictionary: NSDictionary) {
        self.text = dictionary["text"] as! String
      //  self.options_limit = dictionary["options_limit"] as! Int
        self.valid_retry = dictionary["valid_retry"] as! Int

        if let optionArray = dictionary["options"] as? [NSDictionary] {
        for option in optionArray{
            self.options.append(Option(option))
        }
        }
        for choice in dictionary["choices"] as! [NSDictionary]{
            self.choices.append(Choice(choice))
        }
    }
}

struct Choice {
    let label:String
    let value:String
   
    init(_ dictionary: NSDictionary) {
        self.label = dictionary["label"] as! String
        self.value = dictionary["value"] as! String
    }
}


struct Prop {
    let onesource:String
    let valid_retry:Int
   
    init(_ dictionary: NSDictionary) {
        self.onesource = dictionary["onesource"] as! String
        self.valid_retry = dictionary["valid_retry"] as! Int
    }
}

struct QuickReply {
    let text:String
    let data:String
    let templateId:String
    let type:String
    init(_ dictionary: NSDictionary) {
        self.text = dictionary["button_text"] as! String
        self.data = "\(dictionary["data"] ?? "")"
        self.templateId = "\(dictionary["template_id"] ?? "")"
        self.type = dictionary["type"] as! String
    }
}

struct Carousal {
    var carouselObjects:[CarousalObject] = []
     init(_ carouselObjectArray: [NSDictionary]) {
        for carouselObj in carouselObjectArray{
        carouselObjects.append(CarousalObject(carouselObj))
        }
    }
}

struct CarousalObject {
    let image:String
    let text:String
    var options:[Option] = []

    init(_ dictionary: NSDictionary) {
        self.text = dictionary["text"] as! String
        self.image = dictionary["image"] as! String
        for option in dictionary["options"] as! [NSDictionary]{
            self.options.append(Option(option))
        }
    }
}



struct Option {
    let data:String
    let label:String
    let uId:String
    let type:String
    init(_ dictionary: NSDictionary) {
        self.label = String(dictionary["label"] as! String)
        self.data = "\(String(describing: dictionary["data"]))"
        self.uId = String(dictionary["uid"] as! String)
        self.type = String(dictionary["type"] as! String)
    }
}


//struct Response : Codable {
//
//    let response:[String]?
//}







