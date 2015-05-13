//
//  FileCollectionView.swift
//  SwiftFilesZip
//
//  Created by Anthony Levings on 13/05/2015.
//  Copyright (c) 2015 Gylphi. All rights reserved.
//

import Foundation

import UIKit

// see for custom UICollectionViewCell - http://randexdev.com/2014/08/uicollectionviewcell/

class FileViewController: UICollectionViewController, UICollectionViewDataSource {
    
    var fileURLs:[NSURL] = FileList.allFilesAndFolders(inDirectory: NSSearchPathDirectory.DocumentDirectory, subdirectory: "Inbox")!
    
    // Number of cells to begin with. This int will be incremented and decremented when cells are added and deleted.
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1 // The number of sections we want
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileURLs.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell // Create the cell from the storyboard cell
        
        cell.contentView.backgroundColor = UIColor.lightTextColor() // Change the background colour of the cell
        let cellLabel = UILabel(frame: CGRect(x: 0, y: cell.contentView.frame.height/2, width: self.view.frame.width/5, height: cell.contentView.frame.height/3))
        cellLabel.text = fileURLs[indexPath.item].path?.lastPathComponent
        cell.contentView.addSubview(cellLabel)
        
        return cell; // Return the cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        // segue to UITextView and open file
        
        
        // self.removeItemAtIndex(indexPath) // a cell has been tapped call the method to delete it
        
    }
    
    
    // when the user selects a cell, and collectionView:didSelectItemAtIndexPath: is called, it then calls the following method
    func removeItemAtIndex(index:NSIndexPath) {
        fileURLs.removeAtIndex(index.item) // update the data model by decrementing the int
        self.collectionView!.deleteItemsAtIndexPaths([index]) // update the interface
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}