//
//  APIManager.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 30/10/19.
//  Copyright © 2019 Ajeet Sharma. All rights reserved.
//

import Foundation
import UIKit

//typealias ImageDownloadCompletion = (_ image: UIImage?) -> ()


class APIManager{
    
    static let sharedInstance = APIManager()
    private init() {
    }

    //"https://devkbbot.xavlab.xyz/api/v2/config/bot/1a1WsV8vx7K5eginfZX73DFy3F6"
    
    func getConfiguration(url:String ,successBlock:@escaping (_ response:ConfigData?) -> Void, failureBlock:@escaping (_ error : String)->Void)
{    //https://mqa.xavlab.xyz/settings/managebot/1a1WsVdKmnxgpMTZJwzIEJCRJNs
    let url = URL(string: "\(Assistent.baseUrl)/api/v2/config/bot/\(Assistent.botId)") //1a1WsV8vx7K5eginfZX73DFy3F6
    URLSession.shared.dataTask(with: url!, completionHandler: {
        (data, response, error) in
        if(error != nil){
            print("error")
        }else{
            do{
                print(response)
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                print(json)

                let configData = try JSONDecoder().decode(ConfigData.self, from: data!)
                print("configData === \(configData)")
                if configData.status == "ok"{
                    successBlock(configData)
                }
                else{
                    failureBlock("Failure")
                }
            }catch let error as NSError{
                failureBlock(error.description)
            }
        }
    }).resume()
    
}
    
    func getSuggestion(text:String, contextId:Int, successBlock:@escaping (_ response:[Suggestion]?) -> Void, failureBlock:@escaping (_ error : String)->Void)
    {
        var textString = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""

        
       //let url = URL(string: "https://mqa.xavlab.xyz/genbot/s0/bot/autocomplete/v1?bot_uid=1a1WsVdKmnxgpMTZJwzIEJCRJNs&language=en&text=che&context_id=0")
        let url = URL(string: "\(Assistent.baseUrl)/genbot/s0/bot/autocomplete/v1?bot_uid=\(Assistent.botId)&language=\(Assistent.language)&text=" + textString + "&context_id=\(contextId)")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    print("response=====\(response)")
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                     print("response json=====\(json)")

                    let configData = try JSONDecoder().decode([Suggestion].self, from: data!)
                    if configData.count != 0{
                        print("configData ==== \(configData)")
                        successBlock(configData)
                    }
                    else{
                        failureBlock("Failure")
                    }
                }catch let error as NSError{
                    failureBlock(error.description)
                }
            }
        }).resume()
    }
    
    
    
    func postTranscript(botId:String, email:String, language:String, sessionId:String, user:String, resultString:@escaping (_ resultStr : String)->Void) {

        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        let parameters = ["bot_id": botId, "email": email, "lang": language, "session_id": Int(sessionId) ?? 0, "user": user] as [String : Any]

        //create the url with URL
        let url = URL(string: "\(Assistent.baseUrl)/api/account/chat/history")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            resultString(error.localizedDescription)
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                resultString(error?.localizedDescription ?? "")
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    resultString((json["result"] as! Dictionary<String, Any>)["message"] as! String)

                    // handle json...
                }
            } catch let error {
                resultString(error.localizedDescription)
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    
    func submitNPSSurveyFeedback(reason:[String], score:Int, feedback:String, issue_resolved:Bool, resultString:@escaping (_ resultStr : String)->Void) {
           //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        var parameters = ["reason":reason, "score":score, "feedback":feedback, "issue_resolved":issue_resolved] as [String : Any]
        parameters["session"] = Assistent.userJid
        parameters["segment"] = "bot"
        parameters["kind"] = "mobile"
        parameters["bot_id"] = Assistent.botId
        parameters["lang"] = "en"
        parameters["session_id"] = Int(UserDefaults.standard.value(forKey: "SessionId") as! String)
       
        

           //create the url with URL
           let url = URL(string: "\(Assistent.baseUrl)/api/account/chat/history")! //change the url

           //create the session object
           let session = URLSession.shared

           //now create the URLRequest object using the url object
                  var request = URLRequest(url: url)
                  request.httpMethod = "POST" //set http method as POST

                  do {
                      request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
                  } catch let error {
                      resultString(error.localizedDescription)
                      print(error.localizedDescription)
                  }

                  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                  request.addValue("application/json", forHTTPHeaderField: "Accept")

                  //create dataTask using the session object to send data to the server
                  let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                      guard error == nil else {
                          resultString(error?.localizedDescription ?? "")
                          return
                      }

                      guard let data = data else {
                          return
                      }

                      do {
                          //create json object from data
                          if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                              print(json)
                            resultString("Feedback Sussessfully post.")
                             // resultString((json["result"] as! Dictionary<String, Any>)["message"] as! String)
                            

                              // handle json...
                          }
                      } catch let error {
                          resultString(error.localizedDescription)
                          print(error.localizedDescription)
                      }
                  })
                  task.resume()
              }
       
}
