from flask import Flask, request
from datetime import datetime

app = Flask(__name__)

last_message = "Aucune alerte reçue pour le moment"

@app.route("/", methods=["GET", "POST"])
def webhook():
    global last_message

    if request.method == "POST":
        data = request.get_json(force=True)

        alert = data["alerts"][0]
        labels = alert.get("labels", {})
        annotations = alert.get("annotations", {})

        equipement = labels.get("grafana_folder", "Router central")
        status = alert.get("status", "unknown").upper()
        summary = annotations.get("summary", "Aucune description")
        runbook = annotations.get("runbook_url", "Non défini")
        time = alert.get("startsAt", "")

        last_message = f"""
🚨 ALERTE SUPERVISION

Équipement : {equipement}
Statut     : {status}
Heure      : {time}

Résumé :
{summary}

Procédure de dépannage :
1. Vérifier l’état du conteneur Docker
2. Tester la connectivité ICMP
3. Vérifier la configuration réseau
4. Redémarrer le service si nécessaire

Contact :
- Opérateur réseau
- Responsable supervision

Runbook :
{runbook}
"""
        print(last_message)
        return "OK", 200

    return f"<pre>{last_message}</pre>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)

