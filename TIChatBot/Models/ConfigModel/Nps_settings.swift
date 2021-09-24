/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Nps_settings : Codable {
	let bot_id : String?
	let rating_type : String?
	let rating_scale : String?
	let data : [Data]?
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
		data = try values.decodeIfPresent([Data].self, forKey: .data)
		issue_resolved = try values.decodeIfPresent(Bool.self, forKey: .issue_resolved)
		additional_feedback = try values.decodeIfPresent(Bool.self, forKey: .additional_feedback)
		ratings = try values.decodeIfPresent(Bool.self, forKey: .ratings)
		custom_theme = try values.decodeIfPresent(Bool.self, forKey: .custom_theme)
	}

}