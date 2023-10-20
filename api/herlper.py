def getElementByAttibute(dictionary, attr, value):
    for element in dictionary.items():
        if element.get(attr) == value:
            return element