package com.choong.spr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.MemberDto;
import com.choong.spr.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("signup")
	public void signupForm() {
		
	}
	
	@PostMapping("signup")
	public String signUpProcess(MemberDto member, RedirectAttributes rttr) {
		boolean success = service.addMember(member);
		
		if(success) {
			rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
			return "redirect:/board/list";
		} else {
			rttr.addFlashAttribute("message", "회원가입에 실패했습니다.");
			rttr.addFlashAttribute("member", member);
			return "redirect:/member/signup";
		}
	}
	
	@GetMapping(path="check", params="id")
	@ResponseBody
	public String idCheck(String id) {
		boolean exist = service.hasMemberId(id);
		
		if(exist) {
			return "unavailable";
		} else {
			return "available";
		}
	}
	@GetMapping(path="check", params="email")
	@ResponseBody
	public String emailCheck(String email) {
		boolean exist = service.hasMemberEmail(email);
		
		if(exist) {
			return "unavailable";
		} else {
			return "available";
		}
	}	
	@GetMapping(path="check", params="nickName")
	@ResponseBody
	public String nickNameCheck(String nickName) {
		boolean exist = service.hasMemberNickName(nickName);
		
		if(exist) {
			return "unavailable";
		} else {
			return "available";
		}
	}
	
	@GetMapping("list")
	public void list(Model model) {
		List<MemberDto> list = service.listMember();
		model.addAttribute("memberList", list);
	}
	
	@GetMapping("get")
	public void getMember(String id, Model model) {
		MemberDto member = service.getMemberById(id);
		
		model.addAttribute("member", member);
	}
	
	@PostMapping("edit")
	public String editMember(MemberDto dto, String oldPassword, RedirectAttributes rttr) {
		boolean success = service.editMember(dto, oldPassword);
		
		if(success) {
			rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
		}
		
		rttr.addFlashAttribute("member", dto); // model object
		rttr.addAttribute("id", dto.getId()); // query string
		
		return "redirect:/member/get";
	}
	
	@PostMapping("remove")
	public String removeMember(MemberDto member, RedirectAttributes rttr) {
		boolean success = service.removeMember(member);
		
		if(success) {
			rttr.addFlashAttribute("message", "탈퇴되었습니다.");
			return "redirect:/board/list";
		} else {
			rttr.addAttribute("id", member.getId());
			return "redirect:/member/get";
		}
	}
}