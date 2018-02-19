//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Joseph Davey on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    var tweet: Tweet?
    var user: User?
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureView.af_setImage(withURL: URL(string: (tweet?.profilePic)!)!)
        userNameLabel.text = tweet?.user.name
        handleLabel.text = "@\((tweet?.user.handle)!)"
        timestampLabel.text = tweet?.createdAtString
        tweetLabel.text = tweet?.text
        retweetCount.text = "\(String(describing: (tweet?.retweetCount)!)) Retweets"
        favoriteCount.text = "\(String(describing: (tweet?.favoriteCount!)!)) Favorites"
        
        if tweet?.retweeted == true {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        
        if tweet?.favorited == true {
            likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
    }
    
    @IBAction func retweetButton(_ sender: Any) {
        if (tweet?.retweeted)! {
            APIManager.shared.unRetweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                    print("Printed here")
                } else if let tweet = tweet {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    
                    tweet.retweeted = false
                    let count = tweet.retweetCount
                    tweet.retweetCount = count - 1
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
                }
            }
        } else {
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Error retweeting tweet: \(error)")
                    print("Printed here")
                } else if let tweet = tweet {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    
                    tweet.retweeted = true
                    let count = tweet.retweetCount
                    tweet.retweetCount = count + 1
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                }
            }
        }
    }
 
    @IBAction func favoriteButton(_ sender: Any) {
        self.likeButton.isUserInteractionEnabled = false
        if let favorited = tweet?.favorited {
            if favorited {
                APIManager.shared.unfavorite(tweet!, completion: { (tweet, error) in
                    if let  error = error {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Error unfavoriting tweet: \(error.localizedDescription)")
                        print("Printed here")
                    } else if let tweet = tweet {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                        self.tweet = tweet
                        
                        tweet.favorited = false
                        let count = tweet.favoriteCount
                        tweet.favoriteCount = count! - 1
                        self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                    }
                })
            } else {
                APIManager.shared.favoriteATweet(tweet!, completion: { (tweet, error) in
                    if let  error = error {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Error favoriting tweet: \(error.localizedDescription)")
                        print("Printed here though!")
                    } else if let tweet = tweet {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Successfully favorited the following Tweet: \n\(tweet.text)")
                        self.tweet = tweet
                        
                        tweet.favorited = true
                        let count = tweet.favoriteCount
                        tweet.favoriteCount = count! + 1
                        self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                    }
                })
            }
        } else {
            APIManager.shared.favoriteATweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.likeButton.isUserInteractionEnabled = true
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.likeButton.isUserInteractionEnabled = true
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.tweet = tweet
                    
                    tweet.favorited = true
                    let count = tweet.favoriteCount
                    tweet.favoriteCount = count! + 1
                    self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                }
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
