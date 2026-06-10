# Cinema System

Application that simulates a basic cinema seat reservation system with customer and employee roles.

Customers can: 
- browse movies and screenings,
- choose seats, 
- create reservations,
- view their own reservations, and cancel them.

Employees have a dashboard, with movies CRUD.

## Stack

- Ruby on Rails
- PostgreSQL
- ERB views
- Devise authentication
- TailwindCSS
- Stimulus / Hotwire
- RSpec


## Business rules

Users:
* Users must be signed in to create reservations.
* Customers can browse movies, reserve seats and manage their own reservations.
* Employees can access the employee dashboard and CRUD movies.
* Customers cannot access employee pages.

Screenings and seats:
* A movie can have many screenings.
* A screening belongs to one room.
* A room has many seats.
* A seat must be unique within the same room and row.
* Two screenings cannot start at the exact same time in the same room.

Reservations:
* A customer can reserve one or more seats for a screening.
* The same seat cannot be reserved twice for the same screening.
* A customer can only see and cancel their own reservations.
* Cancelling a reservation removes the reservation and frees its seats.

## Setup

```sh
bundle install
bin/rails db:prepare
```

Start the app:

```sh
bin/dev
```

Then open:

```text
http://localhost:3000
```

## Tests

Run all specs:

```sh
bundle exec rspec
```

Run one spec file:

```sh
bundle exec rspec spec/requests/reservations_spec.rb
```

## Notes

`db/seeds.rb` creates rooms, seats, and screenings, but expects at least three
movies to already exist.
