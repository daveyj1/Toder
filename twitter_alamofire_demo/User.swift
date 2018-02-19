//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var handle: String
    var backGroundURL: String
    var profilePicURL: String
    var followers: Int
    var following: Int
    var tweets: Int
    var bio : String
    private static var _current: User?
    var dictionary: [String: Any]?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        
        if let name = dictionary["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let handle = dictionary["screen_name"] as? String {
            self.handle = handle
        } else {
            self.handle = ""
        }

        if let bgURL = dictionary["profile_background_image_url_https"] as? String {
            backGroundURL = bgURL
        } else {
            backGroundURL = ""
        }
        
        if let pfURL = dictionary["profile_image_url_https"] as? String {
            profilePicURL = pfURL
        } else {
            profilePicURL = ""
        }
        
        if let bio = dictionary["description"] as? String {
            self.bio = bio
        } else {
            self.bio = ""
        }
    
        if let followers = dictionary["followers_count"] as? Int {
            self.followers = followers
        } else {
            self.followers = 0
        }
        
        if let following = dictionary["friends_count"] as? Int {
            self.following = following
        } else {
            self.following = 0
        }
        
        if let tweets = dictionary["statuses_count"] as? Int {
            self.tweets = tweets
        } else {
            self.tweets = 0
        }
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
