/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Result : Codable {
	let uid : String?
	let name : String?
	let note : String?
	let wlcm_msg : String?
	let timezone : String?
	let confidence : Int?
	let life_span : Int?
	let flat_nlu : Bool?
	let avatar : String?
	let header_logo : String?
	let bg_img : String?
	let theme : String?
	let btn_theme : String?
	let theme_colour : String?
	let language : [Language]?
	let vhost : String?
	let broker : String?
	let jid : String?
	let nlu_backend : String?
	let auto_reply : Bool?
	let auto_reply_count : Int?
	let reset_context : Bool?
	let nlu_service : String?
	let nlu_dns : String?
	let nlu_trained_status : Bool?
	let quick_reply : Bool?
	let small_talk : Bool?
	let auto_lang_detection : Bool?
	let off_the_record : Bool?
	let additional_security : Bool?
	let chat_history : Bool?
	let enable_nps : Bool?
	let enable_avatar : Bool?
	let email_conv : Bool?
	let feedback_msg : Feedback_msg?
	let auto_reply_msg : Auto_reply_msg?
	let p_id : String?
	let synced_at : String?
	let trained_at : String?
	let trained : Bool?
	let pro_chat : Pro_chat?
	let sso : Bool?
	let sso_auth_url : String?
	let redirect_url : String?
	let integration : [Integration]?
	let nps_settings : Nps_settings?
	let sso_active : Bool?
	let platform_type : String?

	enum CodingKeys: String, CodingKey {

		case uid = "uid"
		case name = "name"
		case note = "note"
		case wlcm_msg = "wlcm_msg"
		case timezone = "timezone"
		case confidence = "confidence"
		case life_span = "life_span"
		case flat_nlu = "flat_nlu"
		case avatar = "avatar"
		case header_logo = "header_logo"
		case bg_img = "bg_img"
		case theme = "theme"
		case btn_theme = "btn_theme"
		case theme_colour = "theme_colour"
		case language = "language"
		case vhost = "vhost"
		case broker = "broker"
		case jid = "jid"
		case nlu_backend = "nlu_backend"
		case auto_reply = "auto_reply"
		case auto_reply_count = "auto_reply_count"
		case reset_context = "reset_context"
		case nlu_service = "nlu_service"
		case nlu_dns = "nlu_dns"
		case nlu_trained_status = "nlu_trained_status"
		case quick_reply = "quick_reply"
		case small_talk = "small_talk"
		case auto_lang_detection = "auto_lang_detection"
		case off_the_record = "off_the_record"
		case additional_security = "additional_security"
		case chat_history = "chat_history"
		case enable_nps = "enable_nps"
		case enable_avatar = "enable_avatar"
		case email_conv = "email_conv"
		case feedback_msg = "feedback_msg"
		case auto_reply_msg = "auto_reply_msg"
		case p_id = "p_id"
		case synced_at = "synced_at"
		case trained_at = "trained_at"
		case trained = "trained"
		case pro_chat = "pro_chat"
		case sso = "sso"
		case sso_auth_url = "sso_auth_url"
		case redirect_url = "redirect_url"
		case integration = "integration"
		case nps_settings = "nps_settings"
		case sso_active = "sso_active"
		case platform_type = "platform_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uid = try values.decodeIfPresent(String.self, forKey: .uid)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		note = try values.decodeIfPresent(String.self, forKey: .note)
		wlcm_msg = try values.decodeIfPresent(String.self, forKey: .wlcm_msg)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
		confidence = try values.decodeIfPresent(Int.self, forKey: .confidence)
		life_span = try values.decodeIfPresent(Int.self, forKey: .life_span)
		flat_nlu = try values.decodeIfPresent(Bool.self, forKey: .flat_nlu)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
		header_logo = try values.decodeIfPresent(String.self, forKey: .header_logo)
		bg_img = try values.decodeIfPresent(String.self, forKey: .bg_img)
		theme = try values.decodeIfPresent(String.self, forKey: .theme)
		btn_theme = try values.decodeIfPresent(String.self, forKey: .btn_theme)
		theme_colour = try values.decodeIfPresent(String.self, forKey: .theme_colour)
		language = try values.decodeIfPresent([Language].self, forKey: .language)
		vhost = try values.decodeIfPresent(String.self, forKey: .vhost)
		broker = try values.decodeIfPresent(String.self, forKey: .broker)
		jid = try values.decodeIfPresent(String.self, forKey: .jid)
		nlu_backend = try values.decodeIfPresent(String.self, forKey: .nlu_backend)
		auto_reply = try values.decodeIfPresent(Bool.self, forKey: .auto_reply)
		auto_reply_count = try values.decodeIfPresent(Int.self, forKey: .auto_reply_count)
		reset_context = try values.decodeIfPresent(Bool.self, forKey: .reset_context)
		nlu_service = try values.decodeIfPresent(String.self, forKey: .nlu_service)
		nlu_dns = try values.decodeIfPresent(String.self, forKey: .nlu_dns)
		nlu_trained_status = try values.decodeIfPresent(Bool.self, forKey: .nlu_trained_status)
		quick_reply = try values.decodeIfPresent(Bool.self, forKey: .quick_reply)
		small_talk = try values.decodeIfPresent(Bool.self, forKey: .small_talk)
		auto_lang_detection = try values.decodeIfPresent(Bool.self, forKey: .auto_lang_detection)
		off_the_record = try values.decodeIfPresent(Bool.self, forKey: .off_the_record)
		additional_security = try values.decodeIfPresent(Bool.self, forKey: .additional_security)
		chat_history = try values.decodeIfPresent(Bool.self, forKey: .chat_history)
		enable_nps = try values.decodeIfPresent(Bool.self, forKey: .enable_nps)
		enable_avatar = try values.decodeIfPresent(Bool.self, forKey: .enable_avatar)
		email_conv = try values.decodeIfPresent(Bool.self, forKey: .email_conv)
		feedback_msg = try values.decodeIfPresent(Feedback_msg.self, forKey: .feedback_msg)
		auto_reply_msg = try values.decodeIfPresent(Auto_reply_msg.self, forKey: .auto_reply_msg)
		p_id = try values.decodeIfPresent(String.self, forKey: .p_id)
		synced_at = try values.decodeIfPresent(String.self, forKey: .synced_at)
		trained_at = try values.decodeIfPresent(String.self, forKey: .trained_at)
		trained = try values.decodeIfPresent(Bool.self, forKey: .trained)
		pro_chat = try values.decodeIfPresent(Pro_chat.self, forKey: .pro_chat)
		sso = try values.decodeIfPresent(Bool.self, forKey: .sso)
		sso_auth_url = try values.decodeIfPresent(String.self, forKey: .sso_auth_url)
		redirect_url = try values.decodeIfPresent(String.self, forKey: .redirect_url)
		integration = try values.decodeIfPresent([Integration].self, forKey: .integration)
		nps_settings = try values.decodeIfPresent(Nps_settings.self, forKey: .nps_settings)
		sso_active = try values.decodeIfPresent(Bool.self, forKey: .sso_active)
		platform_type = try values.decodeIfPresent(String.self, forKey: .platform_type)
	}

}