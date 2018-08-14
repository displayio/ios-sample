//
//  PlacementWrapper.swift
//  display.io Sample App
//
//  Created by akrat on 8/8/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import Foundation

class PlacementWrapper: NSObject, NSCoding {
    let id: String?
    let name: String?
    let type: String?
    let appId: String?
    
    init(id: String?, name: String?, type: String?, appId: String?) {
        self.id = id
        self.name = name
        self.type = type
        self.appId = appId
    }
    
    required convenience init(coder decoder: NSCoder) {
        let id = decoder.decodeObject(forKey: "id") as? String
        let name = decoder.decodeObject(forKey: "name") as? String
        let type = decoder.decodeObject(forKey: "type") as? String
        let appId = decoder.decodeObject(forKey: "appId") as? String
        self.init(id: id, name: name, type: type, appId: appId)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(type, forKey: "type")
        coder.encode(appId, forKey: "appId")
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let placement = object as? PlacementWrapper {
            return self.id == placement.id && self.appId == placement.appId
        } else {
            return false
        }
    }
}
