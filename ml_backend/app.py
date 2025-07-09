from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import pandas as pd
import os

# Initialize Flask app
app = Flask(__name__)
CORS(app)

BASE_DIR = os.path.dirname(__file__)  # ml_backend/
MODEL_DIR = os.path.join(BASE_DIR, 'models')

model = joblib.load(os.path.join(MODEL_DIR, 'style_predictor.pkl'))
subcategory_encoder = joblib.load(os.path.join(MODEL_DIR, 'subcategory_encoder.pkl'))
color_encoder = joblib.load(os.path.join(MODEL_DIR, 'color_encoder.pkl'))
season_encoder = joblib.load(os.path.join(MODEL_DIR, 'season_encoder.pkl'))
gender_encoder = joblib.load(os.path.join(MODEL_DIR, 'gender_encoder.pkl'))
usage_encoder = joblib.load(os.path.join(MODEL_DIR, 'usage_encoder.pkl'))

@app.route('/')
def home():
    return jsonify({'message': 'CHROMA Style Prediction API is running...'})

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()

    try:
        # Extract features
        baseColour = data['baseColour']
        season = data['season']
        gender = data['gender']
        usage = data['usage']

        # Encode input features
        encoded_input = pd.DataFrame([[
            color_encoder.transform([baseColour])[0],
            season_encoder.transform([season])[0],
            gender_encoder.transform([gender])[0],
            usage_encoder.transform([usage])[0]
        ]], columns=['baseColour', 'season', 'gender', 'usage'])

        # Predict and decode
        pred = model.predict(encoded_input)[0]
        predicted_label = subcategory_encoder.inverse_transform([pred])[0]

        return jsonify({'predicted_subCategory': predicted_label})

    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)
