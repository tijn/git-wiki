class String
  def wiki_linked
    self.gsub!(/\b((?:[A-Z]\w+){2,})/) { |m| "<a href=\"/e/#{m}\">#{m}</a>" }
    self
  end
end

class Time
  def for_time_ago_in_words
    "#{(self.to_i * 1000)}"
  end
end

module Uv
  def Uv.syntax_for_file_extension(ext)
    ext.delete!(".")
    return ext if Uv.syntaxes.include?(ext)
    
    equivs = { 'js' => 'javascript',
               'pl' => 'perl',
               'py' => 'python',
               'rb' => 'ruby' }
    equivs[ext]
  end
end