# README

# Private Events

A Rails app, similar to a private Eventbrite, where users create events,
invite specific people, and manage who attends.

## Features

- Sign up, sign in and sign out with Devise
- Create events with a title, description, date and location
- Events are **private by default**; only the creator and invited users can see them
- Creators invite specific users from a dropdown
- Attend events you can see (many-to-many through a join table)
- Home page splits events into upcoming and past
- Profile pages list the events a user created and is attending

## Data model

```
users ──< events            (creator_id)
users >──< events           via attendances (attendee_id, attended_event_id)
users >──< events           via invitations (invitee_id, event_id)
```

| Table | Purpose |
|---|---|
| `users` | Devise accounts |
| `events` | Events, with a `creator_id` and an `is_private` flag |
| `attendances` | Join table: who is attending which event |
| `invitations` | Join table: who was invited to which event |

Both join tables have a unique index on the pair of columns, so no one can
attend or be invited to the same event twice.

## What I practiced

- Many-to-many associations with custom `class_name`, `foreign_key` and `source` options
- Two different relationships between the same two models (creating vs. attending)
- Scopes with lambdas (`past`, `upcoming`, `visible_to`)
- Authorization in controllers, not only in views
- Building through associations (`current_user.created_events.build`)

## Run it locally

Requirements: Ruby 8.0, PostgreSQL

```bash
git clone git@github.com:YOUR_USERNAME/private-events.git
cd private-events
bundle install
rails db:create db:migrate
rails server
```

Then visit `http://localhost:3000` and sign up.


## Possible next steps

- Let creators edit and delete their events
- Let users cancel their attendance
- Let creators toggle an event between public and private
