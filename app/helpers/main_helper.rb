module MainHelper
    def render_with_hashtags(text)
        text.gsub(/#\w+/){|word| link_to word, "/main/#{word.delete("#")}/hashtag", class: "hashtagname"}.html_safe
    end 
end
