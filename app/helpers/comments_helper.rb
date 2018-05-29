module CommentsHelper
	def nested_comments(comments)
		comments.map do |comment, sub_comments|
			content_tag(:div, render(comment), :class => "media", :style => "margin-left: 30px; padding: 4px;")
		end.join.html_safe
	end
end
