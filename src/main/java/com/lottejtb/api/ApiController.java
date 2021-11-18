package com.lottejtb.api;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ApiController {
    
    private final Logger logger = Logger.getLogger(this.getClass());
    private final String _rootPath = "/";
    

    @RequestMapping(value="/apiean.do")
    public String apiean(HttpServletRequest request, Model model) throws Exception {
                
        return _rootPath+"api/apiean";
    }
    
    @RequestMapping(value="/googleMap.do")
    public String googleMap(HttpServletRequest request, Model model) throws Exception {
        
        return _rootPath+"googleMap";
    }
    
    @RequestMapping(value="/googleMap2.do")
    public String googleMap2(HttpServletRequest request, Model model) throws Exception {
        
        return _rootPath+"googleMap2";
    }
    
    
}