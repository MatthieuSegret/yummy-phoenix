defmodule YummyWeb.PageController do
  use YummyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
