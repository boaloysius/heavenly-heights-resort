# Heavenly Heights Resort

This project is a luxury hotel management system built with a Rails API backend and a Vue.js frontend. The frontend code is located in the `/client` directory of the Rails repository.

## Table of Contents

- [Demo](#demo)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Backend Setup](#backend-setup)
- [Frontend Setup](#frontend-setup)
- [Running the Application](#running-the-application)
- [Courtesy](#courtesy)

# Demo

[![Watch the video](https://img.youtube.com/vi/oyXrhzy9Wz4/1.jpg)](https://www.youtube.com/watch?v=oyXrhzy9Wz4)

## Prerequisites

Ensure you have the following installed on your local development environment:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails](https://guides.rubyonrails.org/getting_started.html)
- [Node.js and npm](https://nodejs.org/)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Foreman](https://github.com/ddollar/foreman#installation)

## Installation

### Backend Setup

1. Clone the repository:

   ```sh
   git clone https://github.com/boaloysius/heavenly-heights-resort.git
   cd heavenly-heights-resort
   ```

2. Install backend dependencies:

   ```sh
   bundle install
   ```

3. Configure the database:

   Edit the `config/database.yml` file to match your PostgreSQL configuration.

4. Create and migrate the database:
   ```sh
   rails db:create
   rails db:migrate
   ```

### Frontend Setup

1. Navigate to the `client` directory:

   ```sh
   cd client
   ```

2. Install frontend dependencies:
   ```sh
   npm install
   ```

## Running the Application

### Start the servers with Foreman:

From the root directory of the project, run:

```sh
foreman start
```

## Run tests

```sh
bundle exec rspec spec/requests
```

## Courtesy

- **Website Theme**: [The Ultimate React Course 2024: React, Next.js, Redux & More](https://www.udemy.com/course/the-ultimate-react-course)
- **Image**: [Freepik.com](https://www.freepik.com)
  - **Hero Image**: [Photorealistic House with Wooden Architecture](https://www.freepik.com/free-ai-image/photorealistic-house-with-wooden-architecture-timber-structure_152579043.htm#query=desktop%20themes%20log%20cabin&position=1&from_view=keyword&track=ais_hybrid&uuid=9c26dd03-1ee5-4414-8842-db5295e3f8a6)
