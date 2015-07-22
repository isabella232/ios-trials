#!/usr/bin/python 

# https://github.com/AFNetworking/AFNetworking/issues/1381
# Request failed: unacceptable content-type: text/xml

import SimpleHTTPServer
import SocketServer
import mimetypes

PORT = 8000

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

Handler.extensions_map['.plist']='application/x-plist'
httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()
