class Building:
    def __init__(self, name, location, buildingType):
        self.name = name
        self.location = location
        self.buildingType = buildingType
        self.value = 20
    
    def getName(self):
        return self.name
    
    def getLocation(self):
        return self.location
    
    def getBuildingType(self):
        return self.buildingType

    def getValue(self):
        return self.value
    
    def getDict(self):
        x = {
            "Name": self.name,
            "Location": self.location,
            "buildingType": self.buildingType,
            "Value": self.value
        }
        return x

class Boundary:
    def __init__(self, ne, sw):
        self.ne = ne
        self.sw = sw
    
    def getDict(self):    
        x = {
            "NE" : self.ne,
            "SW" : self.sw
        }
        return x