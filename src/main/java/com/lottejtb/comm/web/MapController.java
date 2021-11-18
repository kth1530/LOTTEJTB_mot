package com.lottejtb.comm.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lottejtb.comm.service.MapVO;


@Controller
public class MapController {
    @RequestMapping(value = "/map/info")
    public String goToInfo(@ModelAttribute("mapVO") MapVO mapVo, Model model){
        return "/map/info";
    }
}