//
//  DataManager.swift
//  test_walkthrough
//
//  Created by riko on 2024/02/12.
//

import UIKit
import Foundation
class DataManager: NSObject {
    

}

// mainの情報
struct main_info: Decodable {
    let id: String
    let password: String
}

struct ReceiveData {
    var statusCode: Int
    var data: Data?
    var result:Bool
}

struct LoginRequest: Encodable  {
    let email: String
    let password: String
}


