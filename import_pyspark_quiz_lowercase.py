import json
import requests

# Load your quiz JSON
with open("pyspark_quiz.json", "r") as f:
    cards = json.load(f)

for c in cards:
    # this line adds a unique hidden hash based on the code field
    unique_question = f"{c['question']} <span style='display:none'>[{hash(c.get('code','')) % 10000}]</span>"

    fields = {
        "question": unique_question,
        "code": c.get("code", ""),  # visible code field under question
        "hint": c.get("hint", ""),
        "option1": c["options"][0],
        "option2": c["options"][1],
        "option3": c["options"][2],
        "option4": c["options"][3],
        "correct_answer": c["correct_answer"],
        "description": c["description"],
        "answer_code": c.get("answer_code", ""),
        "reference": c["reference"]
    }

    payload = {
        "action": "addNote",
        "version": 6,
        "params": {
            "note": {
                "deckName": "trial",  # name of your deck
                "modelName": "ai-flashcards",  # your note type
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
        print("⚠️ Could not connect to AnkiConnect. Make sure Anki is open and AnkiConnect is installed.")
        break