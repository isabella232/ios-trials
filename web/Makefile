build:
	rm -f bundle.zip
	cd bundle/Resources ; ibtool ViewController.xib --compile ViewController.nib
	cd bundle ; zip -r ../bundle.zip Resources

server:
	python server.py

copy:
	cp ../trials1/Base.lproj/ViewController.xib bundle/Resources/

# Interface builder could not ...
# sudo killall -9 ibtoold
