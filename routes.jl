using Genie.Router
using Genie.Requests
using Genie.Renderer
using YesMaster.TasksController

route("/", TasksController.tasks, named=:root)
route("/new", method=POST) do
    TasksController.newtask(postpayload(:title), postpayload(:duedate))
    redirect(:root)
end
route("/task/:taskid/status/:newstatus") do
    TasksController.statuschange(payload(:taskid), payload(:newstatus))
    redirect(:root)
end
