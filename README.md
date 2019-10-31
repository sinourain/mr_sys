# Movie Reservation System - MRSys

MRSys is a Sinatra/Grape/Sequel sample application available in Heroku (https://mr-sys.herokuapp.com/).


### Setup

MRSys is developed to work within the following requirements:
- ruby 2.6.3

### Install

Run the following commands:

1) git clone https://github.com/sinourain/mr_sys.git
2) cd mr_sys
3) cp .env.example .env

Configure your env variables in the .env file

4) bundle install
5) psql --user=postgres -c 'create database <DATABASE_NAME_HERE>'
rake db:migrate
6) rackup

Application run with the following local URL:

```
localhost:9292
```

### Run tests

Run the following commands:

1) psql --user=postgres -c 'create database mr_sys_test'
RACK_ENV=test rake db:migrate
2) rspec spec

## Api Examples

### Create a Movie

POST localhost:9292/api/movies

Body

JSON (application/json)
```
{
  "image_url": "http://s3.example.com/cinema/images/123345.jpg", 
  "name": "Example1234",
  "description": "Foo Bar", 
  "presentation_days": ["2019-09-29", "2019-09-30", "2019-10-01"]
}
```

Response
```
{
    "movie": {
        "id": 15,
        "name": "Example1234",
        "description": "Foo Bar",
        "image_url": "http://s3.example.com/cinema/images/123345.jpg",
        "created_at": "2019-09-29 13:54:13 -0500",
        "updated_at": null
    },
    "presentation_days": [
        {
            "id": 43,
            "movie_id": 15,
            "day_name": "Sunday",
            "date": "2019-09-29",
            "created_at": "2019-09-29 13:54:13 -0500",
            "updated_at": null
        },
        {
            "id": 44,
            "movie_id": 15,
            "day_name": "Monday",
            "date": "2019-09-30",
            "created_at": "2019-09-29 13:54:13 -0500",
            "updated_at": null
        },
        {
            "id": 45,
            "movie_id": 15,
            "day_name": "Tuesday",
            "date": "2019-10-01",
            "created_at": "2019-09-29 13:54:13 -0500",
            "updated_at": null
        }
    ]
}
```

### List movies by day name

GET localhost:9292/api/movies?day_name=Friday

Response
```
{
  "movies": [
    {
      "id": 2,
      "name": "Example",
      "description": "Foo Bar",
      "image_url": "http://s3.example.com/cinema/images/123345.jpg",
      "created_at": "2019-08-30T03:37:54.830+00:00",
      "updated_at": null
    },
    {
      "id": 5,
      "name": "Example2",
      "description": "Foo Bar",
      "image_url": "http://s3.example.com/cinema/images/123345.jpg",
      "created_at": "2019-08-30T03:54:32.601+00:00",
      "updated_at": null
    },
    {
      "id": 8,
      "name": "Example4",
      "description": "Foo Bar",
      "image_url": "http://s3.example.com/cinema/images/123345.jpg",
      "created_at": "2019-08-30T03:59:16.296+00:00",
      "updated_at": null
    },
    {
      "id": 11,
      "name": "Example11",
      "description": "Foo Bar",
      "image_url": "http://s3.example.com/cinema/images/123345.jpg",
      "created_at": "2019-08-30T19:49:35.193+00:00",
      "updated_at": null
    }
  ]
}
```

### Create a Reservation

POST localhost:9292/api/reservations

Body

JSON (application/json)
```
{
  "movie_id": "1", 
  "presentation_day_id": "1", 
  "people_number": "2"
}
```

Response
```
{
  "reservation": {
    "id": 3,
    "movie_id": 1,
    "presentation_day_id": 5,
    "people_number": 2,
    "created_at": "2019-09-29 13:58:24 -0500",
    "updated_at": null
  }
}
```

### List reservations between two dates

GET localhost:9292/api/reservations?start_date=2019-08-29&end_date=2019-08-31

Response
```
{
  "reservations": [
    {
      "id": 1,
      "movie_id": 1,
      "presentation_day_id": 1,
      "people_number": 2,
      "created_at": "2019-09-29 13:57:22 -0500",
      "updated_at": null
    },
    {
      "id": 2,
      "movie_id": 1,
      "presentation_day_id": 5,
      "people_number": 2,
      "created_at": "2019-09-29 13:57:31 -0500",
      "updated_at": null
    },
    {
      "id": 3,
      "movie_id": 1,
      "presentation_day_id": 5,
      "people_number": 2,
      "created_at": "2019-09-29 13:58:24 -0500",
      "updated_at": null
    }
  ]
}
```