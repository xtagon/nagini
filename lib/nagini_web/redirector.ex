defmodule NaginiWeb.Redirector do
  use Plug.Redirect

  # NOTE: The trailing slash is important, because if you visit `/admin` without
  # a trailing slash, Ember does not recognize the root URL.
  redirect "/", "/admin/"
end
