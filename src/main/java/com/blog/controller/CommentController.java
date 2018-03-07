package com.blog.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.blog.entity.Blog;
import com.blog.entity.Comment;
import com.blog.service.BlogService;
import com.blog.service.CommentService;
import com.blog.util.ResponseUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/comment")
public class CommentController {

	@Resource
	private CommentService commentService;
	
	@Resource
	private BlogService blogService;
	
	@RequestMapping("/save")
	public String saveComment(Comment comment,HttpServletRequest request,HttpServletResponse response)throws Exception {
		comment.setUserIp(request.getRemoteAddr());
		int resultTotal = 0;
		if(comment.getId()==null) {
			resultTotal = commentService.add(comment);
			Blog blog = blogService.getBlogById(comment.getBlog().getId());
			blog.setReplyHit(blog.getReplyHit()+1);
			blogService.update(blog);
		}else {
			
		}
		JSONObject result = new JSONObject();
		if(resultTotal>0) {
			result.put("success", true);
		}else {
			result.put("success", false);
			result.put("erroeInfo", "评论失败！");
		}
		ResponseUtil.write(response, result);
		return null;
	}
}


