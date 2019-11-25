package com.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.app.modelo.login.UserForm;
import com.app.modelo.login.UserInfo;
import com.app.service.login.UserService;
import com.app.validator.SignupValidator;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@Controller
@RequestMapping("/usermanager")
public class UserManagerController {

	@Autowired
	SignupValidator signupValidator;

	@Autowired
	UserService userService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView model = new ModelAndView("user/list");
		model.addObject("list", userService.list());

		return model;
	}

	@RequestMapping(value = "/listTest", method = RequestMethod.GET)
	public List listTest() {		

		return userService.list();
	}

	@RequestMapping(value = "/changePass/{username}", method = RequestMethod.GET)
	public ModelAndView changePass(@PathVariable("username") String username) {
		ModelAndView model = new ModelAndView("user/change_pass");
		model.addObject("user", userService.findUserByUsername(username));

		return model;
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView save(@ModelAttribute("user") UserInfo user) {
		ModelAndView model = changePass(user.getUsername());
		userService.update(user.getUsername(), user.getPassword());
		model.addObject("msg", "Your password has been changed successfully!");

		return model;
	}

//	@RequestMapping(value = "/signup", method = RequestMethod.GET)
//	public ModelAndView signup() {
//		ModelAndView model = new ModelAndView("signup");
//		model.addObject("userForm", new UserForm());
//
//		return model;
//	}
	
	@RequestMapping(value="/signup", method = RequestMethod.GET)
	 public ModelAndView draftPCAngularRequest(HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception {
		 ModelAndView m = new ModelAndView("signup");
		 m.addObject("userForm", new UserForm());
		 return m;
	 }

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@ModelAttribute("userForm") UserForm userForm, BindingResult result,
			RedirectAttributes redirectAttributes) {

		signupValidator.validate(userForm, result);

		if (result.hasErrors()) {
			return "/usermanager/signup";
		} else {
			userService.add(userForm.getUsername(), userForm.getPassword());
			redirectAttributes.addFlashAttribute("msg", "Your account has been created successfully!");

			return "redirect:/";
		}
	}

}
