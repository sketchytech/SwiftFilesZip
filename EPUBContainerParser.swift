import Foundation

//
//  XMLParser.swift
//  SaveFile
//
//  Created by Anthony Levings on 31/03/2015.
//

public class EPUBContainerParser:NSObject, NSXMLParserDelegate {
    var isManifest = false
    var isSpine = false
    // manifest dictionary links ids to urls
    var manifestDictionary = [String:String]()
    // spine array provides order of chapters
    var spineArray = [String]()
    var fontArray = [String]()
    var imageArray = [String]()
    var contentPath = ""
    var contentPaths = [String]()
    var parentFolder = ""
    var parentFolders = [String]()
    
    // returns ordered list of NSURLs for contents
    public func parseXML(xml:NSURL) -> [NSURL] {
        contentPath = xml.path! + "/"
        if let container = NSXMLParser(contentsOfURL: xml.URLByAppendingPathComponent("META-INF/container.xml")) {
            container.delegate = self
            container.parse()
        }
        // takes account of multiple rootfiles and will return every NSURL in order for multiple versions contained in the rootfile
        while contentPaths.isEmpty == false {
        if let path = contentPaths.first
             {
                let url = NSURL(fileURLWithPath: path)
                let xml = NSXMLParser(contentsOfURL: url)
                parentFolder = parentFolders.first!
                contentPaths.removeAtIndex(0)
                parentFolders.removeAtIndex(0)
                xml?.delegate = self
                xml?.parse()
                
        }
        }
        let urlArray = spineArray.map({NSURL(fileURLWithPath: self.manifestDictionary[$0]!)})
        let returnArray = urlArray.filter({$0 != nil})
        // TODO: build an array of incorrect URLs for missing items
        return returnArray
    }
    
    public func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "rootfile" {
            let content = attributeDict["full-path"] != nil ?  contentPath + attributeDict["full-path"]! as String : contentPath
            contentPaths.append(content)
            let parent = (contentPath as NSString).stringByDeletingLastPathComponent + "/"
            parentFolders.append(parent)
            
        }
        
        if elementName == "manifest" {
            isManifest = true
        }
        else if isManifest == true && elementName == "item" {
            // array of everything, if any NSURLs return nil when constructed then item is missing
            if let id = attributeDict["id"],
                href = attributeDict["href"] {
                    manifestDictionary[id as String] = parentFolder + href as String

                }
            

            // TODO: should this be "else if let" INSTEAD OF "if let"?
            if let mediaType = attributeDict["media-type"],
                    href = attributeDict["href"] {
               if  mediaType as String == "application/vnd.ms-opentype" {

                    fontArray.append(href as String)
                }

            
            else if mediaType as String == "image/png"  || mediaType as String == "image/jpeg" || mediaType as String == "image/jpg" {
                imageArray.append(href as String)
            }
            }
        }
        else if elementName == "spine" {
            isSpine = true
        }
        else if isSpine == true && elementName == "itemref" {
            if let idref = attributeDict["idref"] {
            spineArray.append(idref as String)
            }
            
        }
    }
    
    public func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if let str = string {
            
            
            
            
        }
    }
    
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "manifest" {
            isManifest = false
        }
        else if elementName == "spine" {
            isSpine = false
        }
        
        
    }
    
    public func parserDidEndDocument(parser: NSXMLParser) {
        
        
    }
    
}