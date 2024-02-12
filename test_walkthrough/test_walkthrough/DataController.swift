//
//  DataController.swift
//  test_walkthrough
//
//  Created by riko on 2024/02/12.
//

import Foundation

let connectURL = "https://ver.glucoreview.com/api/accounts/login"
class DataController: NSObject {
    
    class func session(request: URLRequest) -> ReceiveData {
        let semaphore = DispatchSemaphore(value: 0)
        //ここでクエリ結果を受け取る
        var receiveData: ReceiveData = ReceiveData(statusCode: 0, data: nil, result: false)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
                    if ((error) != nil) {
                        // 受信エラー
                        print("受信エラー:\(String(describing: error?.localizedDescription))")
                        semaphore.signal()
                    }
                    else {
                        guard let data = data else { return }
                        if let response = response as? HTTPURLResponse {
                            receiveData.statusCode = response.statusCode
                            print("ステータスコード:\(receiveData.statusCode)")
                        }
                        
                        if receiveData.statusCode != 200 {
                            // 受信エラー
                            print("受信エラー")
                            semaphore.signal()
                        }
                        else {
                            receiveData.data = data
                            semaphore.signal()
                        }
                    }
                }
        
                task.resume()
        
                semaphore.wait()
                //statusCodeを出力
                print(receiveData.statusCode)
                //requestのURLを出力
                print(request)
                let str: String? = String(data: receiveData.data!, encoding: .utf8)
                print("loginApi response: \(str ?? "defaltvalue")")
                return receiveData
        
    }

    class func login(email: String, password: String) -> ReceiveData {

        let url = URL(string: connectURL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // リクエストボディにデータを設定
        let loginRequest = LoginRequest(email: email, password: password)
        do {
                    // LoginRequestオブジェクトをJSONデータにエンコード
                    let jsonData = try JSONEncoder().encode(loginRequest)
                    
                    // JSONデータを文字列に変換
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        // リクエストボディに文字列データを設定
                        request.httpBody = jsonString.data(using: .utf8)
                        // リクエストボディの設定後にログを出力
                        print("### Login Request Body: \(jsonString)")
                    } else {
                        // JSONデータを文字列に変換できない場合のエラーログ
                        print("Error converting JSON data to string")
                        return ReceiveData(statusCode: 0, data: nil, result: false)
                    }
                }  catch {
                print("Error encoding login request: \(error)")
                return ReceiveData(statusCode: 0, data: nil, result: false)
            }
        return session(request: request)
    }

}
