# Nagini

Nagini is a snake who battles at: http://battlesnake.io

## Getting Started

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can use [`localhost:4000`](http://localhost:4000) as a Battlesnake
endpoint.

To modify snake configuration, edit `config/battlesnake.exs`.

## Deployment

Nagini is a Phoenix (Elixir) application without an external database
dependency, so deployment should be easy on various platforms, but the
currently supported way is through Google App Engine.

Note that Google Cloud Compute would be a better deploy target than App Engine
because App Engine does not support us-west1, which is the location nearest to
Battlesnake's engine.

I opted to start with App Engine because the Elixir tutorial for it looked
simpler.

You will need:

  * [GCloud SDK](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu)

See https://cloud.google.com/community/tutorials/elixir-phoenix-on-google-app-engine

Once everything is set up, deploy with:

  * `gcloud app deploy`

## License

Copyright 2019 Justin Workman. All Rights Reserved.
