.PHONY: put parse zip

put:
	rsync -vrt --delete --exclude=.git \
		--exclude=published \
		--exclude=doc \
		--exclude=data \
		--exclude=test \
		. /Volumes/Elder\ Scrolls\ Online/live/AddOns/RulebasedInventory

get:
	cp -f /Volumes/Elder\ Scrolls\ Online/live/SavedVariables/RulebasedInventory.lua data/

getpts:
	cp -f /Volumes/Elder\ Scrolls\ Online/pts/SavedVariables/RulebasedInventory.lua data/

