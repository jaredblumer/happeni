# Happeni

Inspired by Cognitive Behavioral Therapy (CBT), **Happeni** empowers users to create happiness by choosing and anticipating upcoming pleasant events. With personalized reminders, we help you stay focused on the positive moments that brighten your life.

View the app at [Happeni.com](https://happeni.com/)

![Happeni Screen Recording](./app/assets/media/screen-recording.gif)

## Overview

Happeni is a Ruby on Rails web application that lets users log pleasant events they’re looking forward to and receive friendly reminders. The app is designed to help users maintain a positive outlook by focusing on enjoyable future activities, a technique often used in CBT to improve mental well-being.

## Features

- **Event Tracking** – Add and manage upcoming pleasant events with dates and details.
- **Reminders** – Personalized reminders to help you anticipate good things.
- **User-Friendly UI** – Clean, responsive interface styled with TailwindCSS.
- **Account Management** – Sign-up, login, email confirmation (Devise).
- **Spam Protection** – Google reCAPTCHA integration on sign-up forms.
- **Email Delivery** – Mailtrap integration for transactional emails.

## Tech Stack

- **Ruby on Rails 7.2**
- **PostgreSQL**
- **TailwindCSS**
- **Devise** – authentication with confirmation
- **Hotwire (Turbo + Stimulus)**
- **Mailtrap** – for email delivery
- **Google reCAPTCHA** – for spam prevention
- **RSpec** – test suite
- **FactoryBot & Faker** – test data generation
- **Shoulda Matchers** – model spec helpers
- **Heroku** - app hosting and deployment
