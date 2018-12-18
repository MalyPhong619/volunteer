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

get ('/projects/:id/volunteer') do
  @projects = Project.all
  project_id = params[:id].to_i
  @project = Project.find(project_id)
  @volunteers = Volunteer.all
  erb (:volunteers)
end

post ('/projects/:id/volunteer') do
  name = params.fetch("name")
  project_id = params[:id].to_i
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
  @volunteer.save
  @volunteers = Volunteer.all
  erb (:volunteers)
end

get ('/volunteer/:id') do
  @volunteers = Volunteer.all
  id = params[:id].to_i
  @volunteer = Volunteer.find(id)
  @volunteers = Volunteer.all
  erb (:edit_volunteer)
end

post ('/volunteer/:id') do
  name = params.fetch("name")
  id = params[:id].to_i
  @volunteer = Volunteer.find(id)
  @volunteer.update({:name => name, :project_id => nil, :id => nil})
  @volunteers = Volunteer.all
  erb (:edit_volunteer)
end

delete ('/volunteer/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @volunteer.delete
  @volunteers = Volunteer.all
  redirect '/'
end
