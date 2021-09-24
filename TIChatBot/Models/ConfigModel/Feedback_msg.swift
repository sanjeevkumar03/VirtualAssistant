/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Feedback_msg : Codable {
	let en_thumbs_down : String?
	let en_thumbs_up : String?
	let fr_thumbs_down : String?
	let fr_thumbs_up : String?

	enum CodingKeys: String, CodingKey {

		case en_thumbs_down = "en_thumbs_down"
		case en_thumbs_up = "en_thumbs_up"
		case fr_thumbs_down = "fr_thumbs_down"
		case fr_thumbs_up = "fr_thumbs_up"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		en_thumbs_down = try values.decodeIfPresent(String.self, forKey: .en_thumbs_down)
		en_thumbs_up = try values.decodeIfPresent(String.self, forKey: .en_thumbs_up)
		fr_thumbs_down = try values.decodeIfPresent(String.self, forKey: .fr_thumbs_down)
		fr_thumbs_up = try values.decodeIfPresent(String.self, forKey: .fr_thumbs_up)
	}

}