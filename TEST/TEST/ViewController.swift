//
//  ViewController.swift
//  TEST
//
//  Created by José-María Súnico on 20160801.
//  Copyright © 2016 José-María Súnico. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
/*
	var feed: Feed? {
		didSet{
			self.tableView.reloadData()
		}
	}
	
*/
	
	var feed = [("", "1"), ("", "2")]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return feed.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath) as! TableCell
		let item = feed[indexPath.row]
		cell.myImage.image = UIImage()
		cell.label.text = item.1
		
		return cell
	}
}

