//
//  CollectionInfoViewController.swift
//  tvOSSampleApp
//
//  Created by Patrick McConnell on 1/28/16.
//  Copyright © 2016 Odd Networks. All rights reserved.
//

import UIKit
import OddSDKtvOS

class CollectionInfoViewController: UIViewController {
  
  @IBOutlet var collectionThumbnailImageView: UIImageView!
  @IBOutlet var collectionTitleLabel: UILabel!
  @IBOutlet weak var collectionNotesTextView: UITextView!
  
  var collection = OddMediaObjectCollection() {
    didSet {
      configureForCollection()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  

  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let id = segue.identifier else { return }
    switch id {
    case "videoTableEmbed":
      guard let vc = segue.destinationViewController as? CollectionInfoVideoTableViewController else { break }
      
      OddContentStore.sharedStore.objectsOfType(.Video, ids: self.collection.objectIds, callback: { (objects) -> Void in
        if let videos = objects as? Array<OddVideo> {
          vc.videos = videos
        }
      })
      
    default:
      break
    }

  }


  // MARK: - Helpers
  
  func configureForCollection() {
    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      self.collectionTitleLabel?.text = self.collection.title
      self.collectionNotesTextView?.text = self.collection.notes
      
      self.collection.thumbnail { (image) -> Void in
        if let thumbnail = image {
          self.collectionThumbnailImageView?.image = thumbnail
        }
      }
    }
    
  }
  
}
