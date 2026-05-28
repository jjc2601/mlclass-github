# Tensorflow example
from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import pandas as pd
# TODO 0: Install flask/joblib libraries into your ml env
# pip install flask
# pip install flask_cors
# pip install joblib

#Initialize the flask app
app = Flask(__name__)

# CORS allows for cross-origin requests 
# (addresses an error related to accessing endpoints from a different server)
CORS(app)

# --------------------------- Model Setup ------------------------------------
# TODO 1: From your training file, save your trained model as a file (.h5 or .pkl)
# From your training file, add a line of code that saves the trained model in a file format. 
#       If your model was trained using TensorFlow, save it as a .h5 file.
#       If your model was trained using scikit-learn, save it as a .pkl file using joblib
# Train your model as you would normally. This should create a file for the trained model
# Then replace ___file_name__ with your file name. Make sure it is in the same directory 
#    as this file

def load_model(): # loads in the neural network model used for the penguin weight predictor 
    model = joblib.load("hellotensor.pkl")
    return model

  

# TODO 2: From your training file, save your label encoder as a .pkl file using joblib. 
# This will allow your model to convert from a numerical prediction back into its original label 
def label_decoder(model_output): #basically label encodes the the information like penguin type and island 
    return model_output[0]


# TODO 3: Create a function that formats your input data for your model
# Think about what your user might input, and then how it would need to be 
# formatted to be input into your model. For example (ATGC... -> 0123...)
# If using scikit-learn, this may include turning an object into a dataframe
# and label encoding as needed
def format(input):  #formats the row of information into something the model can easily use
    #load encoders
    islandEncoder = joblib.load("islandEncoder.pkl") 
    genderEncoder = joblib.load("sexEncoder.pkl")
    speciesEncoder = joblib.load("speciesEncoder.pkl")
    #encode the info 
    species_encoded = speciesEncoder.transform([input[0]])
    island_encoded = islandEncoder.transform([input[1]])
    gender_encoded = genderEncoder.transform([input[6]])
    #replace original with new encoded info
    input[0] = species_encoded[0]
    input[1] = island_encoded[0]
    input[6] = gender_encoded[0]
    #redefine what the features returned should be
    features  = ["species","island","culmen_length_mm","culmen_depth_mm","flipper_length_mm","body_mass_g","sex"]
    return pd.DataFrame(
        [input],
        columns = features
    )

#TODO 4: Let's put it all together now. 
# Define a function predict that takes in some input and uses your model to
# produce a prediction. Decode the prediction into a human readable format.
def predict(input):
    #formats raw info into new info the model can easily use
    formatted_input = format(input)
    #apply any formating needed
    model = load_model()# Load your model
    prediction = model.predict(formatted_input)
    # Use model.predict(formatted_input) to create a prediction
    # decoded = label_decoder(prediction)
    decoded = label_decoder(prediction)
    #use label_decoder
    return decoded
        
    return result


def run_test():
    # TODO 5 define a sample input for testing. This will be replaced later on by
    # actual user input from the frontend
    #["speicies", "island", "culmen_depth_mm","flipper_length_mm","sex", "culmen_length_mm"]

    SAMPLE_INPUT1 = ["Adelie","Torgersen",39,17.1,191,3050,"FEMALE"] #130  
    SAMPLE_INPUT2 = ["Gentoo","Biscoe",49.9,16.1,213,5400,"MALE"] #345
    print("Testing model prediction with sample input...")
    result1 = predict(SAMPLE_INPUT1) #run prediction
    result2 = predict(SAMPLE_INPUT2) #run prediction
    print("Model Predicted: ", result1)
    print("Model Predicted: ", result2)
    print("End Test")
    return result1, result2


# ------------------------------- ROUTES --------------------------------------
    
    
# This code uses Flask to create an API endpoint 
# TODO 6: replace __yourname___ with your name. This is just to demonstrate how
# you can change api route names to be whatever you want
# Helper function to convert safe floats

@app.route('/api/Johnny_Chen/test', methods=['GET'])
def get_prediction():
    # 1. Get parameters
    species = request.args.get("species", "Adelie") # Default to Adelie if empty
    island = request.args.get("island", "Torgersen")
    sex = request.args.get("sex", "MALE")

    # 2. Safely convert numbers (prevents crash on empty inputs)
    culmen_length = float(request.args.get("culmen_length_mm"))
    culmen_depth = float(request.args.get("culmen_depth_mm"))
    flipper_length = float(request.args.get("flipper_length_mm"))
    body_mass = float(request.args.get("body_mass_g"))

    model_input = [
        species,
        island,
        culmen_length,
        culmen_depth,
        flipper_length,
        body_mass,
        sex
    ]
    
    # 3. Run prediction
# 3. Run prediction
    prediction = predict(model_input)
    return jsonify({"success": True, "prediction": float(prediction)})
# TODO 7: Test it out by running this file (as you would run any python file)
# and then paste this url into your browser, replacing routeName with the route 
# you defined above:  http://127.0.0.1:5000/ + routeName

#http://127.0.0.1:8080/api/Johnny_Chen/test

# ------------------------------- MAIN ----------------------------------------
if __name__ == '__main__':
    run_test() # Runs your test code
    app.run(port=8080) # creates your api at http://127.0.0.1:5000






