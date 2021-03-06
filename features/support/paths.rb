module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /Sign Up/
      '/clients/sign_up'

    when /Login/
      '/' # '/clients/sign_in'


# clients

    when /My Projects/
      '/' # '/projects'

    when /New Project/
      '/projects/new'


# admins

    when /Clients/
      '/clients'

    when /Landmark/
      '/' # cheating

    when /Edit Client (.*)/i
      '/clients/' + $1 + '/edit'

    when /Edit Project (.*)/i
      '/projects/' + $1 + "/edit"

    when /Show Project (.*)/i
      '/projects/' + $1

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
