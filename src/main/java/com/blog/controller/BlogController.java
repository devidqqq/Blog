package com.blog.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.blog.entity.Blog;
import com.blog.entity.Comment;
import com.blog.lucene_search.LuceneSearch;
import com.blog.service.BlogService;
import com.blog.service.CommentService;
import com.blog.util.StringUtil;

@Controller
@RequestMapping("/blog")
public class BlogController {

	@Resource
	private BlogService blogService;
	
	@Resource
	private CommentService commentService;
	
	@RequestMapping("/articles/{id}")
	public ModelAndView details(@PathVariable("id") Integer id,HttpServletRequest request)throws Exception{
		ModelAndView mav = new ModelAndView();
		Blog blog = blogService.getBlogById(id);
		List<String> keyWord = null; 
		if(StringUtil.isNotEmpty(blog.getKeyWord())) {
			keyWord = new LinkedList<String>();
			String[] keyWords = blog.getKeyWord().split(" ");
			List<String> list = new LinkedList<String>();
			for (String string : keyWords) {
				list.add(string);
			}
			keyWord = StringUtil.filterWhite(list);
		}
		blog.setClickHit(blog.getClickHit()+1);
		blogService.update(blog);
		mav.addObject("keyWords",keyWord);
		mav.addObject("blog", blog);
		List<Blog> blogHotList = blogService.findHotReader();
		//获取上一篇和下一篇
		Blog lastBlog = blogService.getLastBlogById(id);
		Blog nextBlog = blogService.getNextBlogById(id);
		String lastAndNextBlog = this.genLastAndNextBlog(lastBlog, nextBlog, request.getServletContext().getContextPath()+"/blog/articles/");
		mav.addObject("lastAndNextBlog", lastAndNextBlog);
		mav.addObject("blogHotList", blogHotList);
		mav.addObject("pageTitle", blog.getTitle());
		
		//查找博客评论
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("blogId", blog.getId());
		map.put("state", 1);
		List<Comment> commentList = commentService.list(map);
		mav.addObject("commentList", commentList);
		mav.addObject("mainPage", "/forground/blog/details.jsp");
		mav.setViewName("mainTemp");
		return mav;
	}
	
	/**
	 * 拼接上一篇下一篇html代码
	 * @param lastBlog
	 * @param nextBlog
	 * @param targetUrl
	 * @return String
	 */
	private String genLastAndNextBlog(Blog lastBlog , Blog nextBlog , String targetUrl) {
		StringBuffer sb = new StringBuffer();
		if(lastBlog==null) {
			sb.append("<p>上一篇：没有了</p>");
		}else {
			sb.append("<p>上一篇：<a href='"+targetUrl+lastBlog.getId()+".html'>"+lastBlog.getTitle()+"</a></P>");
		}
		if(nextBlog==null) {
			sb.append("<p>下一篇：没有了</p>");
		}else {
			sb.append("<p>上一篇：<a href='"+targetUrl+nextBlog.getId()+".html'>"+nextBlog.getTitle()+"</a></P>");
		}
		return sb.toString();
	}
	
	@RequestMapping("/search")
	public ModelAndView search(@RequestParam(value="q",required=false)String q)throws Exception {
		ModelAndView mav = new ModelAndView();
		LuceneSearch search = new LuceneSearch();
		List<Blog> blogSearchList = new ArrayList<Blog>();
		if(StringUtil.isNotEmpty(q)) {
			blogSearchList = search.search(q);
		}
		mav.addObject("blogSearchList", blogSearchList);
		mav.addObject("mainPage", "/forground/blog/searchResult.jsp");
		mav.setViewName("mainTemp");
		return mav;
	}
}


