# Assets Manager

App for citizens that allows easy reporting of property assets absence or inoperability.

## API

**Access point**
http://vancouver-hack-demo.mybluemix.net/

### Resources

#### asset

##### GET

Params:

* id - *string* - asset ID

##### POST

* name - *string* - name
* owner - *string* - owner
* coordinates - *string (latitude,longitude)* - coordinates of the asset
* photos - *string* - comma-separated list of urls

#### ticket

##### POST

* issue - *string* - description of the issue
* issue_type - *string (possible values: Damaged, Misplaced, Overcapacity)* - type of issue being reported
* assetID - *string* - ID of the related asset
* photo - *string* - url of the photo 
* coordinates - *string (latitude,longitude)* - issue coordinates

#### photo_tag

##### GET

* url - *string* - url-encoded URL of the image for recognition