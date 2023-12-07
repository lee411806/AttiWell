package com.attiWell.mypage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MyPageController {
   public ModelAndView myPageMain(@RequestParam(required = false, value = "message") String message,
         HttpServletRequest request, HttpServletResponse response) throws Exception;

   public ModelAndView myOrderDetail(@RequestParam("order_id") String order_id, HttpServletRequest request,
         HttpServletResponse response) throws Exception;

   public ModelAndView cancelMyOrder(@RequestParam("order_id") String order_id, HttpServletRequest request,
         HttpServletResponse response) throws Exception;

   public ModelAndView listMyOrderHistoryAll(@RequestParam Map<String, String> dateMap, HttpServletRequest request,
         HttpServletResponse response) throws Exception;

   // delievery_state별 파라미터값으로 페이지 표시하기 위해 추가
   public ModelAndView listMyOrderHistory(@RequestParam Map<String, String> dateMap,
         @RequestParam(value = "delivery_state", required = false) String deliveryState, HttpServletRequest request,
         HttpServletResponse response) throws Exception;

   public ModelAndView myDetailInfoDisabled(HttpServletRequest request, HttpServletResponse response) throws Exception;

   public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response) throws Exception;

   public ResponseEntity modifyMyInfo(@RequestParam("attribute") String attribute, @RequestParam("value") String value,
         HttpServletRequest request, HttpServletResponse response) throws Exception;

   public ModelAndView myAddress(HttpServletRequest request, HttpServletResponse response) throws Exception;
}