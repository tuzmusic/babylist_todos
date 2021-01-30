# Todo List API

## Overview
Provides a simple API for managing a single public Todo list.

Implemented using Ruby on Rails. There are the standard CRUD endpoints, plus a convenience endpoint for marking a todo as complete without having to send the right payload to the "update" endpoint.

I was asked to explain "why I built this the way I did", but it's Rails, and man does Rails make it easy! I ran `rails generate resource todo` along with the desired columns, and edited some migrations to provide the default `is_done? = false`. I used the default database.

I added a few gems (rspec, pry) and genrated the rspec files, and added a few tests. Then I built the controller step by step adding tests as I went. There's not much to say, since Rails makes it so damn simple! I decided to explicitly specify my HTTP return values, although they're simply the default `200` for all except for sucessful create (201), failed create (400), or successful delete (204).

## Prerequisites
1. ruby v2.6.1
2. bundler
## Install and run

1. Clone this repo
2. Install dependencies: `bundle`
3. Create/migrate the database: `rake db:migrate`
4. Start the rails server: `rails server`
5. Access the api at `localhost:3000`

## Endpoints

### `GET /todos`
Returns all existing Todos.

Response schema:
```json
[
    {
        "id": number,
        "description": string,
        "is_done?": boolean,
        "created_at": date,
        "updated_at": date
    },
]
```

### `POST /todos`
Creates a new Todo, and returns the new Todo.

Request schema:
```json
{ 
     "todo": {
        "description": string, // required
        "is_done?": boolean,  // optional
     }
}
```

### `PATCH /todos/:id`
Updates a Todo, and returns the new Todo.
If a Todo with the provided id is not found, returns 404.

Request schema:
```json
{ 
     "todo": {
        "description": string, // optional
        "is_done?": boolean,  // optional
     }
}
```

### `PUT /todos/complete/:id`
Marks the given Todo as complete.
If a Todo with the provided id is not found, returns 404.
This endpoint does not require a body.

### `DELETE /todos/:id`
Deletes the given Todo.
If a Todo with the provided id is not found, returns 404.
This endpoint does not require a body.