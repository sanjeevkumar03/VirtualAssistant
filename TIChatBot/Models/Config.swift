//
//  Config.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 30/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import Foundation

struct ConfigData : Codable {
    let result:Config?
    let status:String?
}

struct Config : Codable {
    let uid:String?
    let wlcm_msg:String?
    let life_span:Int?
    let avatar:String?
    let theme_colour:String?
    let vhost:String?
    let jid:String?
    let integration:[Integration]?
    let header_logo:String?
    let reset_context:Bool?
    let quick_reply:Bool?
    let sso_active:Bool?
    let sso_auth_url:String?
    let sso:Bool?
    let redirect_url:String?
    let enable_nps:Bool?
    let nps_settings:NPSSettings?
    let language:[Language]?

    
    

}

struct Integration : Codable {
    let settings:Setting?
    let read_more_limit:ReadLimit?
    let bot_id:Int?
}

struct ReadLimit : Codable {
    let character_count:Int?
    let read_more:Bool?
    let expand_text:Bool?
}

struct Setting : Codable {
    let button_colour:String?
    let carousel_color:String?
    let carousel_textcolour:String?
    let response_bubble:String?
    let response_text_icon:String?
    let sender_bubble:String?
    let sender_text_icon:String?
    let widget_textcolour:String?
    let feedback_color:String?
    let theme_colour:String?
}

struct Suggestion : Codable {
    let originalText:String?
    let displayText:String?
}


struct NPSSettings : Codable {
    let bot_id : String?
    let rating_type : String?
    let rating_scale : String?
    let data : [DataDetails]?
    let issue_resolved : Bool?
    let additional_feedback : Bool?
    let ratings : Bool?
    let custom_theme : Bool?

    enum CodingKeys: String, CodingKey {

        case bot_id = "bot_id"
        case rating_type = "rating_type"
        case rating_scale = "rating_scale"
        case data = "data"
        case issue_resolved = "issue_resolved"
        case additional_feedback = "additional_feedback"
        case ratings = "ratings"
        case custom_theme = "custom_theme"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bot_id = try values.decodeIfPresent(String.self, forKey: .bot_id)
        rating_type = try values.decodeIfPresent(String.self, forKey: .rating_type)
        rating_scale = try values.decodeIfPresent(String.self, forKey: .rating_scale)
        data = try values.decodeIfPresent([DataDetails].self, forKey: .data)
        issue_resolved = try values.decodeIfPresent(Bool.self, forKey: .issue_resolved)
        additional_feedback = try values.decodeIfPresent(Bool.self, forKey: .additional_feedback)
        ratings = try values.decodeIfPresent(Bool.self, forKey: .ratings)
        custom_theme = try values.decodeIfPresent(Bool.self, forKey: .custom_theme)
    }

}

//struct NPSSettings : Codable {
//    let bot_id:String?
//    let rating_type:String?
//    let rating_scale:String?
//    let data:[DataDetails]
//    let issue_resolved:Bool?
//    let additional_feedback:Bool?
//    let ratings:Bool?
//    let custom_theme:Bool?
//
//}


struct DataDetails : Codable {
    let rating_wise_questions:[Survey]?
    let lang:String?
    let message:String?
    let min_label:String?
    let max_label:String?
}

struct Survey : Codable {
    let score:Int?
    let question:String?
    let answer_tags:[String]?
}


struct Language : Codable {
    let confidence:Int?
    let displayName:String?
    let lang:String?
}
