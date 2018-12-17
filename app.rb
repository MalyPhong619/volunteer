require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")
require("pry")

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do
  @projects = Project.all
  erb(:input)
end

post ('/') do
  title = params.fetch("title")
  @project = Project.new({:title => title, :id => nil})
  @project.save
  @projects = Project.all
  erb(:input)
end

get ('/projects/:id') do
  id = params[:id].to_i
  @project = Project.find(id)
  erb (:projects)
end

post ('/projects/:id') do
  title = params.fetch("title")
  id = params[:id].to_i
  @project = Project.find(id)
  @project.update({:title => title, :id => nil})
  @projects = Project.all
  redirect '/'
end

delete ('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i)
  @project.delete
  @projects = Project.all
  redirect '/'
end
