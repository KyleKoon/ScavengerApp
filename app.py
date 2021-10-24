from flask import Flask, redirect, url_for, render_template, request
import json, requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from Classes import Building, Boundary

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred) 

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/apiRequest/", methods=['POST'])
def apiRequest():

    url = 'https://api.foursquare.com/v2/venues/explore'

    buildingCategoryDict = {"arts": "4d4b7104d754a06370d81259", 
                            "college": "4d4b7105d754a06372d81259", 
                            "food": "4d4b7105d754a06374d81259", 
                            "nightlife": "4d4b7105d754a06376d81259", 
                            "outdoors": "4d4b7105d754a06377d81259", 
                            "travel": "4d4b7105d754a06379d81259"}
    
    client_id = request.form.get('client-api-id')
    client_secret = request.form.get('client-api-key')
    origin = request.form.get('center-location')
    radius = request.form.get('search-radius')
    maxResults = request.form.get('num-locations')
    buildingType = request.form.get("building-type")
    
    inputVals = [client_id, client_secret, origin, radius, maxResults, buildingType]

    for val in inputVals:
        if val == "" or val == None:
            return redirect(url_for("index"))
        else:
            pass

    categoryId = buildingCategoryDict[buildingType]

    params = dict(
        client_id = client_id,
        client_secret = client_secret,
        v='20211023',
        ll = origin,
        radius= radius,
        limit= maxResults,
        categoryId = categoryId
    )

    resp = requests.get(url=url, params=params)
    data = json.loads(resp.text)

    neLat = data['response']['suggestedBounds']['ne']['lat']
    neLng = data['response']['suggestedBounds']['ne']['lng']
    swLat = data['response']['suggestedBounds']['sw']['lat']
    swLng = data['response']['suggestedBounds']['sw']['lng']

    neLocation = firestore.GeoPoint(neLat, neLng)
    swLocation = firestore.GeoPoint(swLat, swLng)
    
    masterDictionary = {}

    boundary = Boundary(neLocation, swLocation)
    subDict = boundary.getDict()
    masterDictionary['boundary'] = subDict
    
    buildingList = []
    for group in (data['response']['groups']):
        for item in group['items']:
            buildingName = item['venue']['name']
            buildingLat = item['venue']['location']['lat']
            buildingLng = item['venue']['location']['lng']
            buildingType = item['venue']['categories'][0]['name']
            
            location = firestore.GeoPoint(buildingLat, buildingLng)
            content = [buildingName, location, buildingType]
            buildingList.append(Building(buildingName, location, buildingType))
   
    for i in range(len(buildingList)):
        subDict = buildingList[i].getDict()
        masterDictionary[buildingList[i].getName()] = subDict
    
    db = firestore.client()
    documentName = request.form.get('region-title')
    db.collection("Regions").document(documentName).set(masterDictionary)
    
    return redirect(url_for("index"))