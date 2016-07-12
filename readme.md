# Assets Manager

App for citizens that allows easy reporting of property assets absence or inoperability.

## API

**Access point**
http://vancouver-hack-demo.mybluemix.net/

### Resources

#### asset

**GET**
Params:
- id - *string* - asset ID

**POST**
Params:
- name - *string* - name
- owner - *string* - owner
- location - *string (latitude,longitude)* - coordinates of the asset
- photos - *string* - comma-separated list of urls

#### ticket

**POST**
Params:
- description - *string* - description of the issue
- assetID - *string* - ID of the related asset
- issue_type - *string (possible values: Damaged, Missplaced, Overcapacity)* - type of issue being reported
- photo - *string* - url of the photo 
- location - *string (latitude,longitude)* - issue coordinates


