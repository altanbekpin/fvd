from rdflib import Graph

def read_owl_file(file_path):
    # Create a new RDF graph
    g = Graph()
    
    # Load the OWL data from the file
    g.parse(file_path, format="xml")
    
    # Query the graph for the data you need
    # For example, let's print all the triples in the graph
    for subject, predicate, obj in g:
        print(f"Subject: {subject}, Predicate: {predicate}, Object: {obj}")

# Replace 'your_file.owl' with the actual path to your OWL file
read_owl_file('./Tilqural25082023.owl')
