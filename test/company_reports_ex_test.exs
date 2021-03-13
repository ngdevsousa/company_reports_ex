defmodule CompanyReportsExTest do
  use ExUnit.Case

  describe "build/1" do
    test "it should return a report based on the filename provided" do
      result =
        "test.csv"
        |> CompanyReportsEx.build()

      expected_result = %{
        "all_hours" => %{
          "Cleiton" => 2,
          "Daniele" => 24,
          "Danilo" => 0,
          "Diego" => 0,
          "Giuliano" => 18,
          "Jakeliny" => 16,
          "Joseph" => 0,
          "Mayk" => 10,
          "Rafael" => 0,
          "Vinicius" => 0
        },
        "hours_per_month" => %{
          "Cleiton" => %{"junho" => 2},
          "Daniele" => %{"abril" => 14, "dezembro" => 10},
          "Danilo" => %{},
          "Diego" => %{},
          "Giuliano" => %{"favereiro" => 18},
          "Jakeliny" => %{"julho" => 16},
          "Joseph" => %{},
          "Mayk" => %{"dezembro" => 10},
          "Rafael" => %{},
          "Vinicius" => %{}
        },
        "hours_per_year" => %{
          "Cleiton" => %{"2020": 2},
          "Daniele" => %{"2016": 10, "2018": 14},
          "Danilo" => %{},
          "Diego" => %{},
          "Giuliano" => %{"2017": 6, "2019": 12},
          "Jakeliny" => %{"2017": 16},
          "Joseph" => %{},
          "Mayk" => %{"2017": 2, "2019": 8},
          "Rafael" => %{},
          "Vinicius" => %{}
        }
      }

      assert result == expected_result
    end
  end
end
