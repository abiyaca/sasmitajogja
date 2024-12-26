from flask import Flask, render_template, request, redirect, url_for, session
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector

app = Flask(__name__)
app.secret_key = 'your_secret_key_here'

# Database connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="sasmita_jogja"
)
cursor = conn.cursor()

# Routes
@app.route('/')
def index():
    cursor.execute("SELECT * FROM destinations")
    destinations = cursor.fetchall()
    return render_template('index.html', destinations=destinations, logged_in='user_id' in session)

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = generate_password_hash(request.form['password'])

        cursor.execute("INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
                       (username, email, password))
        conn.commit()
        return redirect(url_for('login'))

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()

        if user and check_password_hash(user[3], password):
            session['user_id'] = user[0]
            session['username'] = user[1]
            return redirect(url_for('index'))

        return "Invalid credentials"

    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

@app.route('/add_review', methods=['GET', 'POST'])
def add_review():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        name = request.form['name']
        location = request.form['location']
        description = request.form['description']
        opening_hours = request.form['opening_hours']
        image_url = request.form['image_url']

        cursor.execute(
            "INSERT INTO destinations (nama, lokasi, deskripsi, jam_buka, image_url) VALUES (%s, %s, %s, %s, %s)",
            (name, location, description, opening_hours, image_url))
        conn.commit()

        return redirect(url_for('index'))

    return render_template('add_review.html')

@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit_review(id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    cursor.execute("SELECT * FROM destinations WHERE id_destinasi = %s", (id,))
    destination = cursor.fetchone()

    if request.method == 'POST':
        name = request.form['name']
        location = request.form['location']
        description = request.form['description']
        opening_hours = request.form['opening_hours']
        image_url = request.form['image_url']

        cursor.execute(
            "UPDATE destinations SET nama = %s, lokasi = %s, deskripsi = %s, jam_buka = %s, image_url = %s WHERE id_destinasi = %s",
            (name, location, description, opening_hours, image_url, id))
        conn.commit()

        return redirect(url_for('index'))

    return render_template('edit_review.html', destination=destination)

@app.route('/delete/<int:id>', methods=['POST'])
def delete_review(id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    cursor.execute("DELETE FROM destinations WHERE id_destinasi = %s", (id,))
    conn.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, port=8000)
