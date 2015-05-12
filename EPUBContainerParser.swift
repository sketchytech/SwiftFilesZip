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
    var contentPath = ""
    var parentFolder = ""
    
    // returns ordered list of NSURLs for contents
    public func parseXML(xml:NSURL) -> [NSURL] {
        contentPath = xml.path! + "/"
        
        if let container = NSXMLParser(contentsOfURL: xml.URLByAppendingPathComponent("META-INF/container.xml")) {
            container.delegate = self
            container.parse()
        }
        
        if let url = NSURL(fileURLWithPath: contentPath),
            xml = NSXMLParser(contentsOfURL: url) {
                xml.delegate = self
                xml.parse()
        }
        let urlArray = map(spineArray, {NSURL(fileURLWithPath: self.manifestDictionary[$0]!)!})
        let returnArray = filter(urlArray, {$0 != nil})
        return returnArray
    }
    
    public func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        if elementName == "rootfile" {
            
            contentPath += attributeDict["full-path"] as! String
            parentFolder = contentPath.stringByDeletingLastPathComponent + "/"
        }
        
        if elementName == "manifest" {
            isManifest = true
        }
        else if isManifest == true && elementName == "item" {
            manifestDictionary[attributeDict["id"] as! String] = parentFolder + (attributeDict["href"] as! String)
        }
        else if elementName == "spine" {
            isSpine = true
        }
        else if isSpine == true && elementName == "itemref" {
            
            spineArray.append(attributeDict["idref"] as! String)
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