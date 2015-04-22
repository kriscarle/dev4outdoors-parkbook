//
//  SecondViewController.swift
//  Parkbook
//
//  Created by Kristofor Carle on 4/12/15.
//  Copyright (c) 2015 Kristofor Carle. All rights reserved.
//

import UIKit
import TwitterKit
import Fabric


class CommentsViewController: TWTRTimelineViewController {
    
      convenience init() {

            
        let client = Twitter.sharedInstance().APIClient
            
        let dataSource = TWTRSearchTimelineDataSource(searchQuery: "#dev4outdoors", APIClient: client)
        self.init(dataSource: dataSource)

        
    }
    
    override required init(dataSource: TWTRTimelineDataSource) {
        super.init(dataSource: dataSource)
    }
    
    required init(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

