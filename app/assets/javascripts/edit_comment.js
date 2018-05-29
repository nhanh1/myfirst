$(document).ready(function(){
	$("a.edit_link").click(function(){
		var id = $(this.closest("div.showComment")).attr("comment_id");
		$("div.showComment[comment_id=" + id + "]").hide();
		$("div.editComment[comment_id=" + id + "]").show();
	})

	$("a.new_link").click(function(){
		$("tr#addComment").hide();
		$("tr#addCommentForm").show();
	})

	$("a.cancel_link").click(function(){
		$("tr#addComment").show();
		$("tr#addCommentForm").hide();
	})
})