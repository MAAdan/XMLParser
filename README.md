# XMLParser
A simple xml parser approach for small but complex XML files.

XML parsing is difficult and most of the times the SAX based parsers (like the NSXMLParser in Cocoa) ends up being an awfull mess of flags and coditions in order keep track of the current state. What this little script does is load the full XML structure into memory like a Dom parser would do. This this allows to iterate the XML tree recursively to create the desired entities.
