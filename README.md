# Heavenly Heights Resort

This project is a luxury hotel management system built with a Rails API backend and a Vue.js frontend. The frontend code is located in the `/client` directory of the Rails repository.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Backend Setup](#backend-setup)
- [Frontend Setup](#frontend-setup)
- [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

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
