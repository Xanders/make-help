def make_help(input)
  sections = input.scan(/(?:##\s*\n## ([^\n]+?)\s*\n##\s*\n|\A)(.+?)(?=\z|\n##\s*\n## [^\n]+\n##\s*\n)/m)

  sections_with_goals = sections.map do |match|
    {match[1]?, match[2].scan(/((?:^# [^\n]+\n)+)^([^#:\n]+):(?!=)/m)}
  end

  commands = sections_with_goals.map(&.last).flatten.map(&.[2])

  return "No commands with comments found" if commands.empty?

  indent = commands.map(&.size).max + 1

  sections_with_goals.map do |(section, goals)|
    result = goals.map do |match|
      comments, command = match[1].lines, match[2]

      help = comments[0].strip + comments[1..-1].map do |comment|
        "\n " + " " * indent + comment
      end.join

      # Highlight `code`
      help = help.gsub(/\`.+?\`/) do |code|
        "\033[36m#{code}\033[0m"
      end

      "\n \033[32m#{command.ljust indent}\033[0m#{help}"
    end

    result.unshift("\n \033[1m\033[31;1m#{section}\033[0m") if section

    next result
  end.flatten.compact.unshift("Commands:").join("\n")
end

puts "\nUsage: make \033[32m<command>\033[0m [ARGUMENT1=value1] [ARGUMENT2=value2]\n\n"

puts make_help(STDIN.gets_to_end)

puts