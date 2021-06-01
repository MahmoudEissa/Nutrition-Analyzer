//
//  NetworkManager.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import ESNetworkManager
import RxSwift
import Alamofire

class NetworkManager: ESNetworkManager {
   public static var session: Session = .default
    
    override class var Manager: Session {
        return session
    }
    
    override class func map(_ response: AFDataResponse<Any>) -> ESNetworkResponse<JSON> {
        if let error = response.error {
            return .failure(error)
        }
        print(response.value ?? "No Response")
        switch response.response?.statusCode {
        case 200:
            return .success(JSON(response.value))
                        
        default:
            return .failure(NSError.init(error: "unexpected status code", code: -1))
        }
    }

}
extension ESNetworkRequest {
    convenience init(_ path: String) {
        let _path = "\(path)?app_id=\(Constants.app_id)&app_key=\(Constants.app_key)"
        self.init(base: Constants.base_url, path: _path)
    }
}
