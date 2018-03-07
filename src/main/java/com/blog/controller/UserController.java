package com.blog.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.blog.entity.User;
import com.blog.service.UserService;
import com.blog.util.CryptographyUtil;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private UserService userService;
	/**
	 * 使用前台传过来的用户实体封装一个token登录令牌
	 * 调用MyRealm中的身份验证
	 * @param user
	 * @param request
	 * @return String
	 */
	@RequestMapping("/login")
	public String loggin(User user,HttpServletRequest request) {
		//获取题目
		Subject subject = SecurityUtils.getSubject();
		//封装用户名和密码生成登录令牌
		UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(), CryptographyUtil.MD5(user.getPassword(), "admin"));
		//登录，调用MyRealm的doGetAuthenticationInfo()方法验证
		try {
			subject.login(token);
			User currentUser = userService.getUserByUserName(user.getUserName());
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", currentUser);
			return "redirect:/admin/main.jsp";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			request.setAttribute("user", user);
			request.setAttribute("errorMsg", "用户名或密码错误！");
			return "login";
		}
	}
}


