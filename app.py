from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Dummy inventory
inventory = [
    {'id': 1, 'name': 'Laptop', 'quantity': 10, 'status': 'In Stock'},
    {'id': 2, 'name': 'Monitor', 'quantity': 5, 'status': 'Low Stock'},
    {'id': 3, 'name': 'Keyboard', 'quantity': 0, 'status': 'Out of Stock'}
]

@app.route('/')
def index():
    return render_template('index.html', inventory=inventory)

@app.route('/add', methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        new_item = {
            'id': len(inventory) + 1,
            'name': request.form['name'],
            'quantity': int(request.form['quantity']),
            'status': request.form['status']
        }
        inventory.append(new_item)
        return redirect(url_for('index'))
    return render_template('form.html', action='Add')

@app.route('/edit/<int:item_id>', methods=['GET', 'POST'])
def edit(item_id):
    item = next((i for i in inventory if i['id'] == item_id), None)
    if request.method == 'POST':
        item['name'] = request.form['name']
        item['quantity'] = int(request.form['quantity'])
        item['status'] = request.form['status']
        return redirect(url_for('index'))
    return render_template('form.html', action='Edit', item=item)

@app.route('/delete/<int:item_id>')
def delete(item_id):
    global inventory
    inventory = [i for i in inventory if i['id'] != item_id]
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

