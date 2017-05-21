//
//  SwiftFilesZipTests.swift
//  SwiftFilesZipTests
//
//  Created by Anthony Levings on 30/04/2015.
//  Copyright (c) 2015 Gylphi. All rights reserved.
//

import UIKit
import XCTest
@testable import SwiftFilesZip
class SwiftFilesZipTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        do {
            try FileSave.saveStringToTemporaryDirectory(fileString: "hello World", path: "myString.txt", subdirectory: "") }
        catch {
            
        }
        
        XCTAssert(true, "Pass")

        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
            do {
                try FileSave.saveStringToTemporaryDirectory(fileString: "hello World", path: "myString.txt", subdirectory: "")
                try FileSave.saveString(fileString: "hello world", directory: FileManager.SearchPathDirectory.documentDirectory, path: "myString.txt", subdirectory: "MyFiles")
                try FileSave.saveString(fileString: "hello world", directory: FileManager.SearchPathDirectory.documentDirectory, path: "yourString.txt", subdirectory: "MyFiles")
                try FileLoad.loadString(path: "myString.txt", directory: FileManager.SearchPathDirectory.documentDirectory, subdirectory: "MyFiles", encoding: String.Encoding.utf8)
                
                do {
                    try FileMove.move(fromPath: "yourString.txt", fromDirectory: .documentDirectory, fromSubdirectory: "MyFiles", toPath: "yourString.txt", toDirectory: .documentDirectory, toSubdirectory: "OurFiles")
                }
                catch {
                    print("error")
                }
                try! FileList.allFilesAndFolders(inDirectory: .documentDirectory, subdirectory: "OurFiles")
                
                let data = "Hello Swift My Friend!".data(using: String.Encoding.utf8)!
                try FileSave.saveData(fileData: data, directory: FileManager.SearchPathDirectory.cachesDirectory, path: "myFile.txt", subdirectory: "Data")
                FileLoad.loadData(path: "myFile.txt", directory: FileManager.SearchPathDirectory.cachesDirectory, subdirectory: "Data") == data // true
                do {
                    if let files = try FileList.allFilesAndFolders(inDirectory: FileManager.SearchPathDirectory.cachesDirectory, subdirectory: "Data") {
                        for file in files {
                            print("Filename:\(file.lastPathComponent) URL:\(file)") //
                        }
                    }
                    else {
                        print("failed to find given location")
                    }
                    
                }
                catch  {
                    print("error occurred")
                }
                
                // find out the location of your files to use in Finder -> Go -> Go to Directory dialogue box
                FileDirectory.applicationDirectory(FileManager.SearchPathDirectory.documentDirectory)
                FileDirectory.applicationTemporaryDirectory()
                
                for files in try FileList.allFilesAndFolders(inDirectory: FileManager.SearchPathDirectory.documentDirectory, subdirectory: "OurFiles")! {
                    files
                }
                // Clean up, deleting files
                try FileDelete.deleteFile(path: "myFile.txt", directory: FileManager.SearchPathDirectory.cachesDirectory, subdirectory: "Data")
                try FileDelete.deleteFile(path: "myString.txt", directory: FileManager.SearchPathDirectory.documentDirectory, subdirectory: "MyFiles")
                try FileDelete.deleteFile(path: "yourString.txt", directory: FileManager.SearchPathDirectory.applicationDirectory, subdirectory: "OurFiles")
                
                
            }
            catch _ {
                print("error")
            }
            
            do {
                try FileLoad.loadString(path: "myString.txt", directory: FileManager.SearchPathDirectory.documentDirectory, subdirectory: "MyFiles", encoding: String.Encoding.utf8) // throws error because file is deleted
            }
            catch _ {
                print("error, because file was deleted")
            }
            
            
         
            
        }
    }
    
}
