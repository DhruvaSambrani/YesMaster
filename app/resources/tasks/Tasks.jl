module Tasks

import SearchLight: AbstractModel, DbId, save!
import Base: @kwdef, convert
using Dates

export Task, TaskStatus,
       isnew, isclosed, isactive, isdeferred, isarchived

@enum TaskStatus new active closed deferred archived

function Base.convert(::Type{TaskStatus}, s::String)
    get(Dict(map(instances(TaskStatus)) do i
        string(i)=>i
    end), s, closed)
end

@kwdef mutable struct Task <: AbstractModel
  id::DbId = DbId()
  title::String = ""
  duedate::Date = Dates.today()+Dates.Day(1)
  status::TaskStatus = new
end

function seed()
     TaskList = Task[
                      Task(title="A test 1", status=active),
                      Task(title="A test 2", status=new),
                      Task(title="A test 3", status=deferred),
                      Task(title="A test 4", duedate=Dates.today()-Dates.Day(1), status=closed),
                     ]
    map(save!, TaskList)
end

isactive(t::Tasks.Task) = t.status == active
isnew(t::Tasks.Task) = t.status == new
isdeferred(t::Tasks.Task) = t.status == deferred
isclosed(t::Tasks.Task) = t.status == closed
isarchived(t::Tasks.Task) = t.status == archived
end
