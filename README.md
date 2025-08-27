# Nagini

Nagini was a snake who used to compete at [Battlesnake](https://play.battlesnake.com/).

The name is not to be confused with all of the other battlesnakes named Nagini.

## Status

This project is no longer in use, and **not currently supported or maintained**. There are known security advisories for outdated dependencies with no current plans to address or update them, and I don't recommend running this without due dilligence. It is left here for historical reasons.

## Getting Started

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Set up the event store with `mix do event_store.create, event_store.init`
  * Start Phoenix endpoint with `mix phx.server`

Now you can use [`localhost:4000`](http://localhost:4000) as a Battlesnake
endpoint.

The logger is configured to log at the debug level (very verbose) and logs are
stored in `/tmp/nagini.log`. This is a workaround for Nanobox stdout log
streaming being broken.

To start your Ember admin frontend:

  * Change to the frontend directory with `cd admin`
  * Install dependencies with `npm install`
  * Start Ember with `./node_modules/.bin/ember serve`

Now you can view [`localhost:4200/admin/`](http://localhost:4200/admin/)

## Configuration

To customize your snake, set these environment variables:

  * `SNAKE_COLOR`
  * `SNAKE_HEAD`
  * `SNAKE_TAIL`

To tune the solver, set these environment variables:

  * `SOLVER_TIMEOUT=infinity`
  * `SOLVER_DEPTH=0`

## Development with Nanobox

  * Install Docker
  * Install Nanobox CLI and log in
  * `nanobox dns add local nagini.local`
  * `nanobox run`
  * Install dependencies and run start commands as normal

Note that Nanobox's Elixir engine may run a different version of Elixir than
this project's .tool-versions lock file expects. This may not behave as
intended.

## Deployment with Nanobox

Test with a dry-run first:

  * `nanobox evar add dry-run PORT=8080 MIX_ENV=prod EMBER_ENV=production`
  * `nanobox evar add dry-run ADMIN_USER=fixme ADMIN_PASS=fixme`
  * `nanobox evar add dry-run APPSIGNAL_APP_NAME="Nagini" APPSIGNAL_APP_ENV="dry-run" APPSIGNAL_PUSH_API_KEY="FIXME"`
  * `nanobox deploy dry-run`
  * Test the dry-run deployed endpoint

Update the release version:

  * Edit `mix.exs`

Deploy:

  * `nanobox remote add app-name`
  * `nanobox evar add app-name PORT=8080 MIX_ENV=prod EMBER_ENV=production`
  * `nanobox evar add app-name ADMIN_USER=fixme ADMIN_PASS=fixme`
  * `nanobox evar add app-name APPSIGNAL_APP_NAME="Nagini" APPSIGNAL_APP_ENV="prod" APPSIGNAL_PUSH_API_KEY="FIXME"`
  * `nanobox deploy`

## Monitoring

Monitoring is set up to work with AppSignal if the environment is configured.

To read the Nanobox server logs:

  * `nanobox console app-name web.main`
  * `tail -f /tmp/nagini.log`

## IEx Console for Nanobox Remote

  * `nanobox console app-name web.main`
  * `iex -S mix phx.server --no-start`

The `--no-start` option prevents the normal applications from being started
because that would throw errors such as the port being in use.

## PSQL Usage for Nanobox Local

  * Find IP and password with `nanobox info local`
  * `PGPASSWORD="" psql -h IP -p 5432 -U nanobox gonano`

## PSQL Usage for Nanobox Remote

  * Start the tunnel with `nanobox tunnel data.event_store -p 5432`
  * Find the password from Nanobox dashboard
  * `psql -p 5432 -h 127.0.0.1 gonano nanobox`
  * Enter the password`

## License

Copyright 2019 Justin Workman. All Rights Reserved.
