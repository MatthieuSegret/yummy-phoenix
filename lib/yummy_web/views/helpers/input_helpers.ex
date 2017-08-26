defmodule YummyWeb.Helpers.InputHelpers do
  use Phoenix.HTML
  alias YummyWeb.Helpers.ErrorHelpers

  def input(form, field, options \\ []) do
    options = build_options(form, field, options)
    wrapper(form, field, options[:type], options[:label_value], options[:input_options], options[:class])
  end

  defp wrapper(form, field, :checkbox, label_value, input_options, class_options) do
    content_tag :div, [class: "field #{class_options}"] do
      [
        content_tag(:div, class: "controle") do
          content_tag(:label, class: "checkbox") do
            input_options = merge_options(input_options, class: "#{state_class(form, field)}")          
            [
              checkbox(form, field, input_options),
              label_value
            ]
          end
        end,
        ErrorHelpers.error_tag(form, field)
      ]
    end
  end

  defp wrapper(form, field, :file_input, label_value, input_options, class_options) do
    content_tag(:div, class: "field #{class_options}") do
      content_tag(:div, class: "file") do
        [
          content_tag :label, [class: "file-label is-medium"] do
            input_options = merge_options(input_options, class: "file-input #{state_class(form, field)}")
            [
              file_input(form, field, input_options),
              content_tag(:span, class: "file-cta") do
                [
                  content_tag(:span, class: "file-icon") do
                    content_tag(:i, "", class: "fa fa-upload")
                  end,
                  content_tag(:span, label_value, class: "file-label")
                ]
              end,
              content_tag(:span, "", class: "file-name is-hidden")
            ]
          end,
          ErrorHelpers.error_tag(form, field)
        ]
      end
    end
  end

  defp wrapper(form, field, type, label_value, input_options, class_options) do
    content_tag :div, [class: "field #{class_options}"] do
      [
        if(label_value, do: label(form, field, label_value, class: "label"), else: ""),
        content_tag(:div, class: "control") do
          input_options = merge_options(input_options, class: state_class(form, field))
          input_tag(type, form, field, input_options)
        end,
        ErrorHelpers.error_tag(form, field)
      ]
    end
  end

  defp state_class(form, field) do
    cond do
      form.errors[field] -> "is-danger"
      true -> nil
    end
  end

  defp input_tag(:textarea, form, field, input_options) do
    input_options = merge_options(input_options, class: "textarea")
    textarea(form, field, input_options)
  end

  defp input_tag(:select, form, field, input_options) do
    content_tag :div, class: "select" do
      select(form, field, input_options[:collection], input_options)
    end
  end

  defp input_tag(type, form, field, input_options) do
    input_options = merge_options(input_options, class: "input")
    apply(Phoenix.HTML.Form, type, [form, field, input_options])
  end

  defp build_options(form, field, options) do
    [
      type: build_type_options(form, field, options),
      input_options: build_input_options(options),
      label_value: build_label_value(field, options),
      class: options[:class]
    ]
  end

  defp build_input_options(options) do
    input_options = options[:input_html] || []
    cond do
      options[:collection] -> input_options ++ [collection: options[:collection]]
      true -> input_options
    end
  end

  defp build_label_value(field, options) do
    case options[:label] do
      false -> false
      nil -> humanize(field)
      _ -> options[:label]
    end
  end

  defp build_type_options(form, field, options) do
    cond do
      options[:collection] -> :select
      options[:using] -> options[:using]
      true -> Phoenix.HTML.Form.input_type(form, field)
    end
  end

  defp merge_options(options, new_options) do
    options
    |> Keyword.merge(new_options)
    |> Keyword.merge(class: "#{options[:class]} #{new_options[:class]}")        
  end

end