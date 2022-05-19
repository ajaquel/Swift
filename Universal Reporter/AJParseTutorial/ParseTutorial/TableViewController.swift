//
//  TableTableViewController.swift
//  AJParseTable
//
//  Created by Alejandro Jaque on 06/05/2015.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TableViewController: PFQueryTableViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate  {

//-----------------------------------------------
    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
//        mapView.showsUserLocation = true
//        mapView.delegate = self
//        mapView.mapType = MKMapType.Hybrid
        CLLocationManager().requestAlwaysAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//-----------------------------------------------
    
    
	// Sign the user out
	@IBAction func signOut(sender: AnyObject) {
		
		PFUser.logOut()
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") as! UIViewController
		self.presentViewController(vc, animated: true, completion: nil)
	}
	
	@IBAction func add(sender: AnyObject) {
		
		dispatch_async(dispatch_get_main_queue()) {
			self.performSegueWithIdentifier("TableViewToDetailView", sender: self)
		}
	}

	// Table search bar
	@IBOutlet weak var searchBar: UISearchBar!
	
	// Initialise the PFQueryTable tableview
	override init(style: UITableViewStyle, className: String!) {
		super.init(style: style, className: className)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
  
		// Configure the PFQueryTableView
        self.parseClassName = "Events"
        self.textKey = "nameEvent"
		self.pullToRefreshEnabled = true
		self.paginationEnabled = false
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
		
		var cell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomTableViewCell!
		if cell == nil {
			cell = CustomTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CustomCell")
		}
		
		// Extract values from the PFObject to display in the table cell
        if let nameEvent = object?["nameEvent"] as? String {
            cell.customNameEvent.text = nameEvent
        }
        if let typeEvent = object?["typeEvent"] as? String {
            cell.customTypeEvent.text = typeEvent
        }
        if let cityEvent = object?["cityEvent"] as? String {
            cell.customCityEvent.text = cityEvent
        }
        if let stateEvent = object?["stateEvent"] as? String {
            cell.customStateEvent.text = stateEvent
        }
        if let rateEvent = object?["rateEvent"] as? String {
            cell.customRateEvent.text = rateEvent
        }
        //Trying to get coordinates from Parse column "coordinatesEvent"
        if let parseLocation = object?["coordinatesEvent"] as? PFGeoPoint {
            cell.customParseLocation.text = "\(parseLocation)"
            println("TableViewController from Parse: \(cell.customParseLocation.text)")
        }
    
    
		// Display Event image thumbnail
		var initialThumbnail = UIImage(named: "question")
        cell.customPicEvent.image = initialThumbnail
        if let thumbnail = object?["picEvent"] as? PFFile {
            cell.customPicEvent.file = thumbnail
            cell.customPicEvent.loadInBackground()
        }
		
		return cell
	}
	
        // In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		// Get the new view controller using [segue destinationViewController].
		var detailScene = segue.destinationViewController as! DetailViewController
		
		// Pass the selected object to the destination view controller.
		if let indexPath = self.tableView.indexPathForSelectedRow() {
			let row = Int(indexPath.row)
			detailScene.currentObject = objects?[row] as? PFObject
		}
	}
	
        // Define the query that will provide the data for the table view
	override func queryForTable() -> PFQuery {
		
		// Start the query object
        var query = PFQuery(className: "Events")
		
		// Add a where clause if there is a search criteria
		if searchBar.text != "" {
			query.whereKey("searchText", containsString: searchBar.text.lowercaseString)
		}
		
		// Order the results
        query.orderByAscending("nameEvent")
		
		// Return the qwuery object
		return query
	}
	
	func searchBarTextDidEndEditing(searchBar: UISearchBar) {
		
		// Dismiss the keyboard
		searchBar.resignFirstResponder()
		
		// Force reload of table data
		self.loadObjects()
	}
	
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		
		// Dismiss the keyboard
		searchBar.resignFirstResponder()
		
		// Force reload of table data
		self.loadObjects()
	}
	
	
	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		
		// Clear any search criteria
		searchBar.text = ""
		
		// Dismiss the keyboard
		searchBar.resignFirstResponder()
		
		// Force reload of table data
		self.loadObjects()
	}
	
	
	override func viewDidAppear(animated: Bool) {
		
		// Refresh the table to ensure any data changes are displayed
		tableView.reloadData()
		
		// Delegate the search bar to this table view class
		searchBar.delegate = self
        

		
	}

	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return NO if you do not want the specified item to be editable.
		return true
	}
	
	
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// Delete the row from the data source
			let objectToDelete = objects?[indexPath.row] as! PFObject
			objectToDelete.deleteInBackgroundWithBlock {
				(success: Bool, error: NSError?) -> Void in
				if (success) {
					// Force a reload of the table - fetching fresh data from Parse platform
					self.loadObjects()
				} else {
					// There was a problem, check error.description
				}
			}
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
}
