import os

from flask import Flask, flash, redirect, render_template, request, url_for

# Create the Flask application instance used by the web server.
app = Flask(__name__)
app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY", "development-only-key")

# Accept both page loads and form submissions on the home page.
@app.route("/", methods=["GET", "POST"])
def home():
    if request.method == "POST":
        # Read the visitor's name from the submitted form data.
        name = request.form.get("name", "").strip()
        if name:
            flash(
                f"Hello {name}, welcome to the Kubernetes test application!",
                "success",
            )
        return redirect(url_for("home"))

    return render_template("index.html")

if __name__ == "__main__":
    # Listen on all network interfaces so the app can run inside a container.
    app.run(host="0.0.0.0", port=5000)