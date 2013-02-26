/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.diskviewer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Yuriy.Dolgushin
 */
@Controller
public class HomeController {
	@RequestMapping(value = "/home.htm", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
}
