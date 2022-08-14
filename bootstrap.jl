(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using YesMaster
const UserApp = YesMaster
YesMaster.main()
