defmodule Mix.Tasks.Factors do
  use Mix.Task

  def run(args) do
    file = "female-factors"
    factors =
      File.stream!("data/#{file}.csv")
      |> CSV.decode(headers: true)
      |> Enum.map fn row ->
          {:ok, row} = row

          ~s("#{row["Age"]}":
              {
                "Km": {
                  "5": "#{row["5km"]}",
                  "6": "#{row["6km"]}",
                  "8": "#{row["8km"]}",
                  "10": "#{row["10km"]}",
                  "12": "#{row["12km"]}",
                  "15": "#{row["15km"]}",
                  "20": "#{row["20km"]}",
                  "21.1": "#{row["H. Mar"]}",
                  "25": "#{row["25km"]}",
                  "30": "#{row["30km"]}",
                  "42.2": "#{row["Marathon"]}",
                  "50": "#{row["50km"]}",
                  "100": "#{row["100km"]}",
                  "150": "#{row["150km"]}",
                  "200": "#{row["200km"]}"
                },
                "Miles": {
                  "4": "#{row["4Mile"]}",
                  "5": "#{row["5Mile"]}",
                  "10": "#{row["10Mile"]}",
                  "50": "#{row["50Mile"]}",
                  "100": "#{row["100Mile"]}"
                }
              },
          )
        end

      File.open("data/#{file}.json", [:write], fn file ->
        IO.write(file, factors)
      end)
  end
end
