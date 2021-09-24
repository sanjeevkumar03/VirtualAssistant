/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Settings : Codable {
	let autosuggestion_font : Autosuggestion_font?
	let button_colour : String?
	let carousel_color : String?
	let carousel_textcolour : String?
	let datetime_font : Datetime_font?
	let default : Bool?
	let defualt : Bool?
	let font_family : Font_family?
	let header_enable : String?
	let header_logo : Header_logo?
	let response_bubble : String?
	let response_text_icon : String?
	let sender_bubble : String?
	let sender_text_icon : String?
	let text_font : Text_font?
	let theme_colour : String?
	let widget_textcolour : String?

	enum CodingKeys: String, CodingKey {

		case autosuggestion_font = "autosuggestion_font"
		case button_colour = "button_colour"
		case carousel_color = "carousel_color"
		case carousel_textcolour = "carousel_textcolour"
		case datetime_font = "datetime_font"
		case default = "default"
		case defualt = "defualt"
		case font_family = "font_family"
		case header_enable = "header_enable"
		case header_logo = "header_logo"
		case response_bubble = "response_bubble"
		case response_text_icon = "response_text_icon"
		case sender_bubble = "sender_bubble"
		case sender_text_icon = "sender_text_icon"
		case text_font = "text_font"
		case theme_colour = "theme_colour"
		case widget_textcolour = "widget_textcolour"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		autosuggestion_font = try values.decodeIfPresent(Autosuggestion_font.self, forKey: .autosuggestion_font)
		button_colour = try values.decodeIfPresent(String.self, forKey: .button_colour)
		carousel_color = try values.decodeIfPresent(String.self, forKey: .carousel_color)
		carousel_textcolour = try values.decodeIfPresent(String.self, forKey: .carousel_textcolour)
		datetime_font = try values.decodeIfPresent(Datetime_font.self, forKey: .datetime_font)
		default = try values.decodeIfPresent(Bool.self, forKey: .default)
		defualt = try values.decodeIfPresent(Bool.self, forKey: .defualt)
		font_family = try values.decodeIfPresent(Font_family.self, forKey: .font_family)
		header_enable = try values.decodeIfPresent(String.self, forKey: .header_enable)
		header_logo = try values.decodeIfPresent(Header_logo.self, forKey: .header_logo)
		response_bubble = try values.decodeIfPresent(String.self, forKey: .response_bubble)
		response_text_icon = try values.decodeIfPresent(String.self, forKey: .response_text_icon)
		sender_bubble = try values.decodeIfPresent(String.self, forKey: .sender_bubble)
		sender_text_icon = try values.decodeIfPresent(String.self, forKey: .sender_text_icon)
		text_font = try values.decodeIfPresent(Text_font.self, forKey: .text_font)
		theme_colour = try values.decodeIfPresent(String.self, forKey: .theme_colour)
		widget_textcolour = try values.decodeIfPresent(String.self, forKey: .widget_textcolour)
	}

}