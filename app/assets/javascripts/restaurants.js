class Restaurant {
    constructor(id, name, phone, address, city, state) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.city = city;
        this.state = state;
    }
}

Restaurant.prototype.fullAddress = function() {
    return `${this.address}, ${this.city}, ${this.state}`;
}

class Experience {
    constructor(description, rating, user_id) {
        this.description = description;
        this.rating = rating;
        this.user_id = user_id;
    }
}
