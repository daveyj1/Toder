//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            
            if tweet.retweeted == true {
                retweetButton.setImage(UIImage(named: ""), for: .normal)
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
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicImage.layer.cornerRadius = 40
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
