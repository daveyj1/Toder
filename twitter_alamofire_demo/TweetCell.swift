//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            handleLabel.text = "@\(tweet.user.handle)"
            timeStampLabel.text = tweet.createdAtString
            retweetCount.text = "\(String(tweet.retweetCount))"
            favoriteCount.text = "\(String(describing: tweet.favoriteCount!))"
            
            profilePicImage.af_setImage(withURL: URL(string: tweet.profilePic)!)
            profilePicImage.layer.masksToBounds = true
            profilePicImage.layer.cornerRadius = 10
            
            if tweet.retweeted == true {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            } else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
            
            if tweet.favorited == true {
                likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            } else {
                likeButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        if tweet.retweeted {
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                    print("Printed here")
                } else if let tweet = tweet {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
                }
            }
        } else {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    print("Printed here")
                } else if let tweet = tweet {
                    self.retweetButton.isUserInteractionEnabled = true
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                }
            }
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        self.likeButton.isUserInteractionEnabled = false
        if let favorited = tweet.favorited {
            if favorited {
                APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
                    if let  error = error {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Error unfavoriting tweet: \(error.localizedDescription)")
                        print("Printed here")
                    } else if let tweet = tweet {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                        self.tweet = tweet
                        self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                    }
                })
            } else {
                APIManager.shared.favorite(tweet, completion: { (tweet, error) in
                    if let  error = error {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Error favoriting tweet: \(error.localizedDescription)")
                        print("Printed here though!")
                    } else if let tweet = tweet {
                        self.likeButton.isUserInteractionEnabled = true
                        print("Successfully favorited the following Tweet: \n\(tweet.text)")
                        self.tweet = tweet
                        self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                    }
                })
            }
        } else {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    self.likeButton.isUserInteractionEnabled = true
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.likeButton.isUserInteractionEnabled = true
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.tweet = tweet
                    self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //profilePicImage.layer.cornerRadius = 40
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
