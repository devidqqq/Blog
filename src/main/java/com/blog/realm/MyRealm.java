package com.blog.realm;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.realm.AuthenticatingRealm;

import com.blog.entity.User;
import com.blog.service.UserService;

public class MyRealm extends AuthenticatingRealm{

	@Resource
	private UserService userService;
	
	/**
	 * 使用token登录令牌中的用户名查询数据库
	 * 从数据库中查询到实体后，将查询到的实体信息与token中的信息对比
	 * 若信息相同，则身份验证成功
	 * 否则身份验证失败，抛出异常AuthenticationException
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String userName = (String) token.getPrincipal();
		User user = userService.getUserByUserName(userName);
		if(user!=null) {
			//SecurityUtils.getSubject().getSession().setAttribute("currentUser", user); // 把当前用户信息存到session中
			return new SimpleAuthenticationInfo(user.getUserName(), user.getPassword(), "user login");
		}else {
			return null;
		}
	}

}


