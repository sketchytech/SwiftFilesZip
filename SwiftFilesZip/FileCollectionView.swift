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

class FileViewController: UICollectionViewController {
    
    var fileURLs:[URL]? {
        do {
             let files = try FileList.allFilesAndFolders(inDirectory: FileManager.SearchPathDirectory.documentDirectory, subdirectory: "Inbox")
            return files
        }
        catch {
            
        }
        return nil
    }
    
    // Number of cells to begin with. This int will be incremented and decremented when cells are added and deleted.
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // The number of sections we want
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileURLs != nil ? fileURLs!.count : 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // Create the cell from the storyboard cell
        
        cell.contentView.backgroundColor = UIColor.lightText // Change the background colour of the cell
        let cellLabel = UILabel(frame: CGRect(x: 0, y: cell.contentView.frame.height/2, width: self.view.frame.width/5, height: cell.contentView.frame.height/3))
        cellLabel.text = ((fileURLs![indexPath.item].path) as NSString).lastPathComponent
        cell.contentView.addSubview(cellLabel)
        
        return cell; // Return the cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // segue to UITextView and open file
        
        
        // self.removeItemAtIndex(indexPath) // a cell has been tapped call the method to delete it
        
    }
    
    
    // when the user selects a cell, and collectionView:didSelectItemAtIndexPath: is called, it then calls the following method
    func removeItemAtIndex(_ index:IndexPath) {
        if fileURLs != nil && fileURLs!.count > 0 {
            //update the data model by decrementing the int
            do {
             try FileManager.default.removeItem(at: fileURLs![index.item])
            }
            catch {
                print("could not delete file")
            }

            self.collectionView!.deleteItems(at: [index]) // update the interface
            
        }
        
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
