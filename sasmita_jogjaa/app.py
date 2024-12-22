from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import os

# Initialize Flask app
app = Flask(__name__)
app.secret_key = "your_secret_key"
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///jogja_review.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize the database
db = SQLAlchemy(app)

# Database Models
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), nullable=False, unique=True)
    email = db.Column(db.String(150), nullable=False, unique=True)
    password = db.Column(db.String(150), nullable=False)

class Destination(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text, nullable=False)
    image_url = db.Column(db.String(500), nullable=False)
    google_maps_url = db.Column(db.String(500), nullable=True)

class Review(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    destination_id = db.Column(db.Integer, db.ForeignKey('destination.id'), nullable=False)
    review_text = db.Column(db.Text, nullable=False)
    image_url = db.Column(db.String(500), nullable=True)

# Routes
@app.route('/')
def index():
    destinations = Destination.query.all()
    reviews = Review.query.all()  # Query semua review untuk menampilkan gambar
    return render_template('index.html', destinations=destinations, reviews=reviews)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        user = User.query.filter_by(email=email).first()
        if user and check_password_hash(user.password, password):
            session['user_id'] = user.id
            flash('Login successful!', 'success')
            return redirect(url_for('index'))
        flash('Invalid credentials', 'danger')
    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = generate_password_hash(request.form['password'])
        user = User(username=username, email=email, password=password)
        db.session.add(user)
        db.session.commit()
        flash('Registration successful! Please log in.', 'success')
        return redirect(url_for('login'))
    return render_template('register.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('Logged out successfully.', 'success')
    return redirect(url_for('index'))

@app.route('/add_review', methods=['GET', 'POST'])
def add_review():
    if 'user_id' not in session:
        flash('You need to log in to add a review.', 'warning')
        return redirect(url_for('login'))

    if request.method == 'POST':
        destination_id = request.form['destination_id']
        review_text = request.form['review_text']
        image_url = request.form['image_url']

        # Validasi untuk memastikan URL gambar tidak kosong
        if not image_url.strip():
            flash('Image URL is required.', 'danger')
            return redirect(url_for('add_review'))

        new_review = Review(user_id=session['user_id'], destination_id=destination_id, review_text=review_text, image_url=image_url)
        db.session.add(new_review)
        db.session.commit()
        flash('Review added successfully!', 'success')
        return redirect(url_for('index'))

    destinations = Destination.query.all()
    return render_template('add_review.html', destinations=destinations)

@app.route('/destination/<int:id>')
def destination_detail(id):
    destination = Destination.query.get_or_404(id)
    reviews = Review.query.filter_by(destination_id=id).all()
    return render_template('destination_detail.html', destination=destination, reviews=reviews)

if __name__ == '__main__':
    # Create the database if it doesn't exist
    if not os.path.exists('jogja_review.db'):
        with app.app_context():
            db.create_all()
    # Run the app
    app.run(debug=True)
