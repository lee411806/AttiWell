package com.bookshop01.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.common.base.BaseController;
import com.bookshop01.member.service.MemberService;
import com.bookshop01.member.vo.MemberVO;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl extends BaseController implements MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberVO memberVO;
	
	@Override
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		 memberVO=memberService.login(loginMap);
		if(memberVO!= null && memberVO.getMember_id()!=null){
			if(memberVO.getDel_yn().equals("N")) {
				HttpSession session=request.getSession();
				session=request.getSession();
				session.setAttribute("isLogOn", true);
				session.setAttribute("memberInfo",memberVO);
				
				String action=(String)session.getAttribute("action");
				if(action!=null && action.equals("/order/orderEachGoods.do")){
					mav.setViewName("forward:"+action);
				}else{
					mav.setViewName("redirect:/main/main.do");	
				}
			} else {
				String message = "Ż���� ȸ���Դϴ�. �ٽ� �α������ּ���";
				mav.addObject("message", message);
				mav.setViewName("/member/loginForm");
			}
		}else{
			String message="���̵�  ��й�ȣ�� Ʋ���ϴ�. �ٽ� �α������ּ���";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		    memberService.addMember(_memberVO);
		    message  = "<script>";
		    message +=" alert('ȸ�� ������ ���ƽ��ϴ�.�α���â���� �̵��մϴ�.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('�۾� �� ������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	// ȸ��Ż�� �߰�
	@Override
	@RequestMapping(value="/deleteMember.do", method = RequestMethod.POST)
	public ResponseEntity deleteMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("utf-8");
	    String message = null;
	    ResponseEntity resEntity = null;
	    HttpHeaders responseHeaders = new HttpHeaders();
	    responseHeaders.add("Content-Type", "text/html; charset=utf-8");

	    try {
	        HttpSession session = request.getSession();
	        MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
	        if (memberInfo != null) {
	        	message = "<script>";
	        	message += "confirm(delMem('���� Ż���Ͻðڽ��ϱ�?'))";
	        	message += "if (delMem) {";
	        	
	            // ���ǿ��� member_id ����
	        	String member_id = memberInfo.getMember_id();

	            // ���� member_id�� SQL �������� ����� �� �ֽ��ϴ�.
				MemberVO memberVO = new MemberVO();
				memberVO.setMember_id(member_id);

	            // ���񽺸� ȣ���Ͽ� ���� �۾� ����
	            memberService.deleteMember(memberVO);

	            // ���� �Ӽ� ����
	            session.setAttribute("isLogOn", false);
	            session.removeAttribute("memberInfo");

	            message += " alert('Ż��Ǿ����ϴ�. �������� �̵��մϴ�.');";
	            message += " location.href='" + request.getContextPath() + "/main/main.do';";
	            message += "} else {";
	            message += " alert('Ż�� ��ҵǾ����ϴ�.');";
	            message += " location.href='" + request.getContextPath() + "/mypage/myPageMain.do';";
	            message += "}";
	            message += " </script>";
	        } else {
	            // memberInfo�� null�� ��� ó�� (������ �ùٸ��� �������� ���� ���)
	            message = "<script>";
	            message += " alert('������ �ùٸ��� �������� �ʾҽ��ϴ�.');";
	            message += " location.href='" + request.getContextPath() + "/mypage/myPageMain.do';";
	            message += " </script>";
	        }
	    } catch (Exception e) {
	        message = "<script>";
	        message += " alert('�۾� �� ������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���');";
	        message += " location.href='" + request.getContextPath() + "/mypage/myPageMain.do';";
	        message += " </script>";
	        e.printStackTrace();
	    }

	    resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
	    return resEntity;
	}
	
	
	@Override
	@RequestMapping(value="/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String result = memberService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
}
