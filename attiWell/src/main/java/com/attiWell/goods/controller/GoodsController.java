package com.attiWell.goods.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface GoodsController {
   public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id, HttpServletRequest request,
         HttpServletResponse response) throws Exception;

   public @ResponseBody String keywordSearch(@RequestParam("keyword") String keyword, HttpServletRequest request,
         HttpServletResponse response) throws Exception;

   public ModelAndView searchGoods(@RequestParam Map<String, String> dateMap,
         @RequestParam("searchWord") String searchWord,
         @RequestParam(value = "sort", defaultValue = "latest") String sort, HttpServletRequest request,
         HttpServletResponse response) throws Exception;

//   allGoodsList Ãß°¡   
   public ModelAndView allGoodsList(@RequestParam Map<String, String> dateMap,
         @RequestParam(value = "sort", defaultValue = "latest") String sort, HttpServletRequest request,
         HttpServletResponse response) throws Exception;
   
   @RequestMapping(value = "/selectGoodsList.do", method = RequestMethod.GET)
   public ModelAndView selectGoodsList(@RequestParam Map<String, String> dateMap,
         @RequestParam(value = "sort", defaultValue = "latest") String sort,
         HttpServletRequest request,
         HttpServletResponse response,
         @RequestParam(value = "category", required = false) String category)
         throws Exception;
}