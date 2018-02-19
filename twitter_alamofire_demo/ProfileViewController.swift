//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Joseph Davey on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = User.current?.name
        handleLabel.text = "@\((User.current?.handle)!)"
        bioLabel.text = User.current?.bio
        tweetsLabel.text = String(describing: (User.current?.tweets)!)
        followersLabel.text = String(describing: (User.current?.followers)!)
        followingLabel.text = String(describing: (User.current?.following)!)
        profilePictureView.af_setImage(withURL: URL(string: (User.current?.profilePicURL)!)!)
        backgroundImageView.af_setImage(withURL: URL(string: (User.current?.backGroundURL)!)!)
        
        profilePictureView.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
