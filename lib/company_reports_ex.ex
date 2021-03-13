alias CompanyReportsEx.Parser
alias CompanyReportsEx.DateUtils

defmodule CompanyReportsEx do
  @employees [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Danilo",
    "Rafael",
    "Vinicius"
  ]

  def build(filename) do
    filename
    |> Parser.from_file()
    |> Enum.reduce(build_report_acc(), fn line, report -> sum_values(line, report) end)
  end

  def build_report_acc() do
    all_hours = Enum.into(@employees, %{}, &{&1, 0})
    hours_per_month = Enum.into(@employees, %{}, &{&1, %{}})
    hours_per_year = Enum.into(@employees, %{}, &{&1, %{}})

    build_base_map(all_hours, hours_per_month, hours_per_year)
  end

  defp sum_values([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    month = DateUtils.get_month_string(month, "pt-BR")

    all_hours = Map.put(all_hours, name, all_hours[name] + hours)
    hours_per_month = sum_nested_values(hours_per_month, name, month, hours)
    hours_per_year = sum_nested_values(hours_per_year, name, year, hours)

    build_base_map(all_hours, hours_per_month, hours_per_year)
  end

  defp build_base_map(all_hours, hours_per_month, hours_per_year),
    do: %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }

  defp sum_nested_values(map, key, nested_key, value) do
    Map.put(
      map,
      key,
      Map.put(map[key], nested_key, safe_sum(map[key][nested_key], value))
    )
  end

  defp safe_sum(x, y) when is_nil(x), do: 0 + y
  defp safe_sum(x, y) when is_integer(x) when is_integer(y), do: x + y

  # def get_unique_names(filename) do
  #   filename
  #   |> Parser.from_file()
  #   |> Enum.map(&List.first/1)
  #   |> Enum.uniq()
  # end
end
