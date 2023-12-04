package com.attiWell.member.service;

import java.util.Map;

import com.attiWell.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	//È¸¿øÅ»Åð Ãß°¡
	public void deleteMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
}
