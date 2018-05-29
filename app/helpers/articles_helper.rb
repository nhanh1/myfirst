module ArticlesHelper
	def render_new_article(step)
		@step_render = "articles/step_" +  step.to_s
		render partial: @step_render
	end
end
