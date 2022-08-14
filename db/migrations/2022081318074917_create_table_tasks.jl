module CreateTableTasks

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:tasks) do
    [
      pk()
      columns([
        :title => :string
        :duedate => :integer
        :status => :integer
      ])
    ]
  end

  add_indices(:tasks, :title, :status)
end

function down()
  drop_table(:tasks)
end

end
