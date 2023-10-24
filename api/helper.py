def getElementByAttibute(dictionary, attr, value):
    for element in dictionary:
        if element.get(attr) == value:
            return element