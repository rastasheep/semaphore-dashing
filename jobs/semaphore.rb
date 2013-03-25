require 'open-uri'

def update_builds(project, config)
  builds = []
  repo = nil

  api_url = 'https://semaphoreapp.com/api/v1/projects?auth_token=' + config["auth_token"]

  api_response = JSON.parse(open(api_url).read)

  query = project.split('/')

  project = search_project(api_response, query[0])
  puts "There is no project with name: #{query[0]}" unless project

  if query.size > 1
     branch  = search_branch(project,query)
  else
     branch = search_branch_with_last_build(project)
  end

  puts "There is no branch  with name: #{query[1]} in project #{query[0]}" unless branch

 build_info = {
    label: "#{branch['branch_name']}",
    value: "Build #{branch['build_number']}, #{branch['result']} ",
    time: "#{calculate_time(branch['finished_at'])}",
    state: "#{branch['result']}"
  }
  builds << build_info

  builds
end

def search_project(response, project)
  response.select{ |proj| proj['name'] == project }.first
end

def search_branch(project, branch)
  project['branches'].select{ |bran| bran['branch_name'] == branch[1] }.first
end

def search_branch_with_last_build(project)
  project['branches'].sort_by{ |branch| branch['started_at'] }.last
end

def calculate_time(finished)
  if finished
    duration(Time.now - Time.parse(finished))
  else
    "Not built yet"
  end
end

def duration(time)
  secs  = time.to_int
  mins  = secs / 60
  hours = mins / 60
  days  = hours / 24

  if days > 0
    "#{days} days and #{hours % 24} hours ago"
  elsif hours > 0
    "#{hours} hours and #{mins % 60} minutes ago"
  elsif mins > 0
    "#{mins} minutes and #{secs % 60} seconds ago"
  elsif secs >= 0
    "#{secs} seconds ago"
  end
end

config_file = File.dirname(File.expand_path(__FILE__)) + '/../config/semaphore.yml'
config = YAML::load(File.open(config_file))

SCHEDULER.every '2m', :first_in => 0  do
  unless config['projects'].empty?
    config['projects'].each do |data_id, project|
        send_event(data_id, { items: update_builds(project, config) })
    end
  else
    puts "Please add some projects to config.semaphore.yml file"
  end
end
