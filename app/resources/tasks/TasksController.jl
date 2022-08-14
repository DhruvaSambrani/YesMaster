module TasksController

using Dates
using Genie.Renderer.Html
using YesMaster.Tasks
using SearchLight

function tasks()
    ts = all(Tasks.Task)
    html(
         :tasks,
         :tasks, 
         tasksnew = filter(isnew, ts), 
         tasksclosed = filter(isclosed, ts), 
         tasksdeferred = filter(isdeferred, ts), 
         tasksactive = filter(isactive, ts),
         tasksarchived = filter(isarchived, ts)
    )
end

function statuschange(id, newstatus)
    SearchLight.query("UPDATE tasks SET status=\"$(newstatus)\" WHERE id=$(id)")
end

function newtask(title, duedate)
    newt = Tasks.Task(title=title, duedate=duedate)
    if ! ispersisted(newt)
        newt |> save!
    end
end

module API

using ..TasksController
using Genie.Renderer.Json
using SearchLight
using YesMaster.Tasks

function tasks()
  json(:tasks, :tasks, tasks = all(Tasks.Task))
end

end

end
