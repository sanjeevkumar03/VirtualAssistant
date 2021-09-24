/*
 MIT License

 Copyright (c) 2017-2018 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation
import CoreLocation
import UIKit
//import MessageKit

private struct CoordinateItem: LocationItem {

    var location: CLLocation
    var size: CGSize

    init(location: CLLocation) {
        self.location = location
        self.size = CGSize(width: 240, height: 240)
    }

}

private struct ImageMediaItem: MediaItem {

    var urlStr: String?
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize

    init(image: UIImage, urlStr:String) {
        self.image = image
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage(named: "Image")!
        self.urlStr = urlStr
    }
}

private struct QRButton: QuickReplyButton {
    
     var quickReplyButton: QuickReply?
    init(qrButton: QuickReply) {
        self.quickReplyButton = qrButton
    }
}

private struct QRButtonSSO: QuickReplySSOProtocol {
    
     var quickReplySSOResponse: Response?
    init(qrSSOResponse: Response) {
        self.quickReplySSOResponse = qrSSOResponse
    }
}

private struct PropStructure: PropProtocol {
    
     var prop: Prop?
    init(prop: Prop) {
        self.prop = prop
    }
}

private struct MultiOpsStructure: MultiOpsProtocol {
    
     var multiOps: MultiOps?
    init(multiOps: MultiOps) {
        self.multiOps = multiOps
    }
}

private struct CarouselObject: CarouselProtocol {
    
    var carousel: Carousal?
    init(carousel: Carousal) {
        self.carousel = carousel
    }
}

internal struct MockMessage: MessageType {

    var messageId: String
    var sender: Sender
    var sentDate: Date
    var kind: MessageKind

    private init(kind: MessageKind, sender: Sender, messageId: String, date: Date) {
        self.kind = kind
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
    }
    
    init(custom: Any?, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .custom(custom), sender: sender, messageId: messageId, date: date)
    }
    
    init(bottom: Any?, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .bottom(bottom), sender: sender, messageId: messageId, date: date)
    }

    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .text(text), sender: sender, messageId: messageId, date: date)
    }

    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .attributedText(attributedText), sender: sender, messageId: messageId, date: date)
    }

    init(image: UIImage, urlStr: String, sender: Sender, messageId: String, date: Date) {
        let mediaItem = ImageMediaItem(image: image, urlStr: urlStr)
        self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, date: date)
    }

    init(thumbnail: UIImage, url:URL, sender: Sender, messageId: String, date: Date) {
        var mediaItem = ImageMediaItem(image: thumbnail, urlStr: "")
        mediaItem.url = url
        self.init(kind: .video(mediaItem), sender: sender, messageId: messageId, date: date)
    }

    init(location: CLLocation, sender: Sender, messageId: String, date: Date) {
        let locationItem = CoordinateItem(location: location)
        self.init(kind: .location(locationItem), sender: sender, messageId: messageId, date: date)
    }

    init(emoji: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .emoji(emoji), sender: sender, messageId: messageId, date: date)
    }
    
    init(quickReplyButton: QuickReply, sender: Sender, messageId: String, date: Date) {
        let qRButton = QRButton(qrButton: quickReplyButton)
        self.init(kind: .quickReplyButton(qRButton), sender: sender, messageId: messageId, date: date)
    }
    
    init(qrSSOResponse: Response, sender: Sender, messageId: String, date: Date) {
        let qRButtonSSO = QRButtonSSO(qrSSOResponse: qrSSOResponse)
        self.init(kind: .quickReplySSO(qRButtonSSO), sender: sender, messageId: messageId, date: date)
    }
    
    init(prop: Prop, sender: Sender, messageId: String, date: Date) {
           let prop = PropStructure(prop: prop)
           self.init(kind: .prop(prop), sender: sender, messageId: messageId, date: date)
       }
    
    init(multiOptional: MultiOps, sender: Sender, messageId: String, date: Date) {
              let multiOps = MultiOpsStructure(multiOps: multiOptional)
              self.init(kind: .multiOps(multiOps), sender: sender, messageId: messageId, date: date)
          }
    
    init(carousel: Carousal, sender: Sender, messageId: String, date: Date) {
        let carouselObj = CarouselObject(carousel: carousel)
        self.init(kind: .carousel(carouselObj), sender: sender, messageId: messageId, date: date)
    }
    
   

}
