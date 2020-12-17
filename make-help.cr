def make_help(input)
  goals = input.scan(/^\w[^:]*:/m)

  return "No commands found" if goals.empty?

  indent = goals.map(&.[0].size).max + 1

  with_comments = input.scan(/((?:^# [^\n]+\n)+)^([^:]+):/m)

  return "No comments found" if with_comments.empty?

  with_comments.map do |match|
    comments, command = match[1].lines, match[2]

    help = comments[0].strip + comments[1..-1].map do |comment|
      "\n " + " " * indent + comment
    end.join

    # Highlight `code`
    help = help.gsub(/\`.+?\`/) do |code|
      "\033[36m#{code}\033[0m"
    end

    "\n \033[32m#{command.ljust indent}\033[0m#{help}"
  end.unshift("Commands:").join("\n")
end

puts "\nUsage: make \033[32m<command>\033[0m [ARGUMENT1=value1] [ARGUMENT2=value2]\n\n"

puts make_help(STDIN.gets_to_end)

puts