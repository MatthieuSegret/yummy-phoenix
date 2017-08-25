defmodule YummyWeb.Helpers.KeroseneHelpers do  
  use Phoenix.HTML
  import Kerosene.Paginator, only: [build_options: 1]

  def paginate(conn, paginator, opts \\ []) do
    opts = build_options(opts)

    conn 
    |> Kerosene.Paginator.paginate(paginator, opts) 
    |> render_page_list(opts[:class])
  end

  defp render_page_list(page_list, additional_class) do
    content_tag :nav, class: "pagination" do
      content_tag :ul, class: "pagination-list" do
        for {label, _page, url, current} <- page_list do
          content_tag :li do
            link "#{label}", to: url, class: "#{build_current_class(current)} pagination-link #{additional_class}"
          end
        end
      end
    end
  end

  defp build_current_class(true), do: "is-current"
  defp build_current_class(false), do: ""
end