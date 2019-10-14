require "nokogiri"
require "pry"

# require libraries/modules here

def create_project_hash
  
  projects = {}
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html).css("li.project.grid_4")
  
  title = kickstarter.css("h2.bbcard_name strong a")
  image = kickstarter.css("div.project-thumbnail a img").attribute("src").value
  description = kickstarter.css("p.bbcard_blurb")
  location = kickstarter.css("ul.project-meta li a")
  funding = kickstarter.css("ul.project-stats li.first.funded strong")

  kickstarter.css("h2.bbcard_name strong a").each { |title|
    projects[title.text] = {
      :image_link => nil,
      :description => nil,
      :location => nil,
      :percent_funded => nil
    }
  }
  
  projects.each_with_index { |(proj, info), i|
    info[:percent_funded] = funding.map{|funds|funds.text.chop.to_i}[i]
  }
  binding.pry
  projects
end

create_project_hash

# projects: kickstarter.css("li.project.grid_4")

# title: project.css("h2.bbcard_name strong a").text

# image: project.css("div.project-thumbnail a img").attribute("src").value

# description: project.css("p.bbcard_blurb").text

# location: project.css("ul.project-meta li a").text

# funding: project.css("ul.project-stats li.first.funded strong").text