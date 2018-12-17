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
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  erb(:input)
end

get ('/projects/:id') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects)
end

post ('/projects/:id') do
  project_id = params[:id]
  name = params.fetch("name")
  volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
  volunteer.save
  @volunteers = Volunteer.all
  erb(:projects)
end
