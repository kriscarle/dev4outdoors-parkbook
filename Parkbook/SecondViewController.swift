//
//  SecondViewController.swift
//  Parkbook
//
//  Created by Kristofor Carle on 4/12/15.
//  Copyright (c) 2015 Kristofor Carle. All rights reserved.
//

import UIKit
import TwitterKit


class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            // play with Twitter session
        })
        
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var width:CGFloat = bounds.size.width
        var height:CGFloat = bounds.size.height
    
        logInButton.center.x = self.view.frame.origin.x + (width / 2)
        logInButton.center.y = self.view.frame.origin.y + 50
            
        self.view.addSubview(logInButton)
        
        var commentButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        commentButton.frame  = CGRectMake(16, 116, 288, 30)
        commentButton.center.x = self.view.frame.origin.x + (width / 2)
        commentButton.center.y = self.view.frame.origin.y + 150
        commentButton.backgroundColor = UIColor.lightGrayColor()
        commentButton.setTitle("Comment on Twitter", forState: UIControlState.Normal)
        commentButton.addTarget(self, action: "commentOnTwitter:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(commentButton)
        
        
        var feedButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        feedButton.frame  = CGRectMake(16, 116, 288, 30)
  
        feedButton.center.x = self.view.frame.origin.x + (width / 2)
        feedButton.center.y = self.view.frame.origin.y + 250
        feedButton.backgroundColor = UIColor.lightGrayColor()
        feedButton.setTitle("View Twitter Comments", forState: UIControlState.Normal)
        feedButton.addTarget(self, action: "showFeed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(feedButton)


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func commentOnTwitter(sender: UIButton!)
    {
        let composer = TWTRComposer()
        
        composer.setText("#NationalMall")
        composer.setImage(UIImage(named: "fabric"))
        
        composer.showWithCompletion { (result) -> Void in
            if (result == TWTRComposerResult.Cancelled) {
                println("Tweet composition cancelled")
            }
            else {
                println("Sending tweet!")
            }
        }
        
    }
    
    func showFeed(sender: UIButton!)
    {
        
        Twitter.sharedInstance().logInGuestWithCompletion { (session: TWTRGuestSession!, error: NSError!) in
            //let client = Twitter.sharedInstance().APIClient
            //let dataSource = TWTRSearchTimelineDataSource(searchQuery: "#dev4outdoors", APIClient: client)
            //let viewController = TWTRTimelineViewController(dataSource: dataSource)
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let viewController = storyboard.instantiateViewControllerWithIdentifier("CommentsViewController") as! CommentsViewController
self.parentViewController?.navigationController?.pushViewController(viewController, animated: true)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

