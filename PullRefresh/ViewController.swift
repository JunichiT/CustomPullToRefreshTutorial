//
//  ViewController.swift
//  PullRefresh
//
//  Created by Gabriel Theodoropoulos on 6/6/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblDemo: UITableView!
    
    var refreshControl: PullToRefreshManager!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    var dataArray: Array<String> = ["One", "Two", "Three", "Four", "Five"]
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tblDemo.dataSource = self
        tblDemo.delegate = self
        refreshControl = PullToRefreshManager()
        tblDemo.addSubview(refreshControl)
    }
    
    func doSomething() {
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
    }
    
    func endOfWork() {
        refreshControl.endRefreshing()
        timer.invalidate()
        timer = nil
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing {
            if !refreshControl.isAnimating {
                doSomething()
                refreshControl.beginAnimation()
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pullDistance = max(0.0, -self.refreshControl.frame.origin.y);
        print(pullDistance)
        if pullDistance < 60.0 {
            refreshControl.alpha = 1/60.0 * pullDistance
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }

}

