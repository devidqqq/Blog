package com.blog.controller.admin;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.blog.entity.Blog;
import com.blog.entity.BlogType;
import com.blog.entity.Link;
import com.blog.entity.User;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.service.LinkService;
import com.blog.service.UserService;
import com.blog.util.ResponseUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/system")
public class SystemAdminController {

	
	@Resource
	private UserService userService;
	
	@Resource
	private LinkService linkService;
	
	@Resource
	private BlogTypeService blogTypeService;
	
	@Resource
	private BlogService blogService;
	
	/**
	 * 刷新系统缓存
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/refreshSystem")
	public String refreshSystem(HttpServletRequest request,HttpServletResponse response)throws Exception{
		ServletContext application=RequestContextUtils.findWebApplicationContext(request).getServletContext();
		
		User currentUser = userService.getUser();
		currentUser.setPassword(null);
		application.setAttribute("user", currentUser);
		
		List<Link> linkList=linkService.list(null); // 查询所有的友情链接信息
		application.setAttribute("linkList", linkList);
		
		List<BlogType> blogTypeList = blogTypeService.blogTypeList();
		application.setAttribute("blogTypeList", blogTypeList);
		
		List<Blog> blogCountListWithTime = blogService.findBlogCountByTime();
		application.setAttribute("blogCountListWithTime", blogCountListWithTime);
		
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}


