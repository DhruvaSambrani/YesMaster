using SearchLight
using SearchLightSQLite

SearchLight.Configuration.load() |> SearchLight.connect
SearchLight.Migrations.last_down()
SearchLight.Migrations.last_up()

