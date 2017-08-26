# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :yummy,
  ecto_repos: [Yummy.Repo]

# Configures the endpoint
config :yummy, YummyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BeS5RSDLBgHNZuNMKhCvh6CMs3wl2OvI8+kjmqGbzNyqNs9Kez+lUPOhy4XtntY+",
  render_errors: [view: YummyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Yummy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :yummy, YummyWeb.Gettext,
  default_locale: "fr"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Yummy.Accounts.User,
  repo: Yummy.Repo,
  module: Yummy,
  web_module: YummyWeb,
  router: YummyWeb.Router,
  messages_backend: YummyWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Yummy",
  email_from_email: "no-reply@yummy.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :registerable]

config :coherence, YummyWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
