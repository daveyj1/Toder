//
//  ComposeTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Joseph Davey on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeTweetControllerDelegate {
    func did(post: Tweet)
}

class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var charCount: UILabel!
    
    var delegate: ComposeTweetControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.delegate = self
        profilePictureView.af_setImage(withURL: URL(string: (User.current?.profilePicURL)!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postTweet(_ sender: Any) {
        tweetButton.isEnabled = false
        APIManager.shared.composeTweet(with: tweetText.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
                self.tweetButton.isEnabled = true
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.tweetButton.isEnabled = true
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetText.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let total = 140 - tweetText.text.count
        if total == 140 || total <= 0 {
            tweetButton.isEnabled = false
            charCount.textColor = .red
        } else {
            tweetButton.isEnabled = true
            charCount.textColor = .lightGray
        }
        
        charCount.text = "\(total)"
    }
}
