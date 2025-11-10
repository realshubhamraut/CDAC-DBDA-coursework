import json
import requests

with open("pyspark_quiz.json", "r") as f:
    cards = json.load(f)

for c in cards:
    fields = {
        "question": c["question"],
        "code": c.get("code", ""),  # visible in question
        "hint": c.get("hint", ""),
        "option1": c["options"][0],
        "option2": c["options"][1],
        "option3": c["options"][2],
        "option4": c["options"][3],
        "correct_answer": c["correct_answer"],
        "description": c["description"],
        "answer_code": c.get("answer_code", ""),  # revealed after answer
        "reference": c["reference"]
    }

    payload = {
        "action": "addNote",
        "version": 6,
        "params": {
            "note": {
                "deckName": "trial",
                "modelName": "ai-flashcards",
                "fields": fields,
                "tags": ["pyspark", "quiz"]
            }
        }
    }

    try:
        res = requests.post("http://localhost:8765", json=payload).json()
        if res.get("error"):
            print(f"❌ Error adding: {c['question']} → {res['error']}")
        else:
            print(f"✅ Added: {c['question']}")
    except requests.exceptions.ConnectionError:
        print("⚠️ Could not connect to AnkiConnect. Make sure Anki is open.")
        break