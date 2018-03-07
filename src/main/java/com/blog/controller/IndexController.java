package com.blog.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.blog.entity.Blog;
import com.blog.entity.PageBean;
import com.blog.service.BlogService;
import com.blog.util.PaginationUtil;
import com.blog.util.StringUtil;

@Controller
@RequestMapping("/")
public class IndexController {
	
	@Resource
	private BlogService blogService;

	@RequestMapping("/index")
	public ModelAndView index(@RequestParam(value="page",required=false)String page,@RequestParam(value="typeId",required=false)String typeId,
			@RequestParam(value="releaseDateStr",required=false)String releaseDateStr,HttpServletRequest request)throws Exception{
		ModelAndView mav = new ModelAndView();
		if(StringUtil.isEmpty(page)) {
			page="1";
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page),10);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		map.put("typeId", typeId);
		map.put("releaseDateStr", releaseDateStr);
		List<Blog> blogList = blogService.blogList(map);
		for(Blog blog:blogList){
			List<String> imageList=blog.getImageList();
			String blogInfo=blog.getContent();
			Document doc=Jsoup.parse(blogInfo);
			Elements jpgs=doc.select("img[src$=.jpg]");
			for(int i=0;i<jpgs.size();i++){
				Element jpg=jpgs.get(i);
				imageList.add(jpg.toString());
				if(i==2){
					break;
				}
			}
		}
		List<Blog> blogHotList = blogService.findHotReader();
		Long total = blogService.blogCount(map);
		StringBuffer param = new StringBuffer();
		if(StringUtil.isNotEmpty(typeId)) {
			param.append("typeId="+typeId+"&");
		}
		if(StringUtil.isNotEmpty(releaseDateStr)) {
			param.append("releaseDateStr="+releaseDateStr);
		}
		String pageCode = PaginationUtil.genPagination(request.getContextPath()+"/index.html", total.intValue(), Integer.parseInt(page), 10, param.toString());
		mav.addObject("pageCode", pageCode);
		mav.addObject("blogHotList", blogHotList);
		mav.addObject("blogList", blogList);
		mav.addObject("pageTitle", "博客首页");
		mav.addObject("mainPage", "/forground/blog/bloglist.jsp");
		mav.setViewName("mainTemp");
		return mav;
	}
}


