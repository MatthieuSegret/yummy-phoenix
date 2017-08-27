# Yummy

This application can be used as **starter kit** if you want to get started building an app with **Elixir** and **Phoenix**.
This is a simple cooking recipe sharing application using ordinary features which can be found in most web applications.

## Technologies

- Elixir 1.5
- Phoenix 1.3
- Erlang 20.0
- [Gettext](https://github.com/elixir-lang/gettext) - Gettext is an internationalization (i18n) and localization (l10n) system commonly used for writing multilingual programs. Use to localize app in French language.
- [Coherence](https://github.com/smpallen99/coherence) - Coherence is a full featured, configurable authentication system for Phoenix.
- [Arc](https://github.com/stavro/arc) - Flexible file upload and attachment library for Elixir.
- [ExAws](https://github.com/CargoSense/ex_aws) - A flexible, easy to use set of clients AWS APIs for Elixir. Use to store attachments in Amazon S3.
- [Kerosene](https://github.com/elixirdrops/kerosene) - Pagination for Ecto and Pheonix.
- [Earmark](https://github.com/pragdave/earmark) - Markdown parser for Elixir.
- PostgreSQL for database.

## Features

- CRUD (create / read / update / delete) on recipes
- Creating comments on recipe page
- Pagination on recipes listing
- Searching on recipes
- Authentication with Coherence and authorizations (visitors, users)
- Creating user account
- Update user profile and changing password
- Uploading recipe photos
- Application ready for production on Heroku

## Prerequisites

- Elixir 1.5 ([Installing Elixir](https://elixir-lang.org/install.html))
- Phoenix 1.3 ([Installing Phoenix](https://hexdocs.pm/phoenix/installation.html))
- PostgreSQL

## Getting Started

- Checkout the yummy git tree from Github

          $ git clone https://github.com/MatthieuSegret/yummy-phoenix.git
          $ cd yummy-phoenix
          yummy-phoenix$

- Install dependencies :

          yummy-phoenix$ mix deps.get

- Create and migrate your database :

          yummy-phoenix$ mix ecto.create && mix ecto.migrate

- Load sample records:

          yummy-phoenix$ mix run priv/repo/seeds.exs

- Run Yarn to install javascript package in other terminal:

          yummy-phoenix$ cd assets
          yummy-phoenix/assets$ yarn

- Start Phoenix endpoint

          yummy-phoenix$ mix phx.server

- Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Screens

#### Listing recipes
<img alt="Listing recipes" src="http://documents.matthieusegret.com/listing-recipes.png" width="500">

#### Editing recipe
<img alt="Editing recipe" src="http://documents.matthieusegret.com/editing-recipe.png" width="500">

#### Recipe page
<img alt="Recipe page" src="http://documents.matthieusegret.com/recipe-page.png" width="500">

## Learn more about Phoenix

- Official website: http://www.phoenixframework.org/
- Guides: http://phoenixframework.org/docs/overview
- Docs: https://hexdocs.pm/phoenix

## License

MIT © [Matthieu Segret](http://matthieusegret.com)