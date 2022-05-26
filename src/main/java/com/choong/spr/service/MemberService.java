package com.choong.spr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.MemberDto;
import com.choong.spr.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public boolean addMember(MemberDto member) {
		
		// 평문 암호를 암호화
		String encodedPassword = passwordEncoder.encode(member.getPassword());
		
		// 암호화 후 세팅
		member.setPassword(encodedPassword);
		
		return mapper.insertMember(member) == 1;
	}

	public boolean hasMemberId(String id) {
		return mapper.countMemberId(id) > 0;
	}

	public boolean hasMemberEmail(String email) {
		return mapper.countMemberEmail(email) > 0;
	}

	public boolean hasMemberNickName(String nickName) {
		return mapper.countMemberNickName(nickName) > 0;
	}

	public List<MemberDto> listMember() {
		return mapper.selectAllMemberList();
	}

	public MemberDto getMemberById(String id) {
		return mapper.selectMemberById(id);
	}

	public boolean editMember(MemberDto dto, String oldPassword) {
		// db에서 member 읽어서
		MemberDto oldMember = mapper.selectMemberById(dto.getId());
				
		String encodedPw = oldMember.getPassword();
		System.out.println(passwordEncoder.matches(oldPassword, encodedPw));
		// 기존password가 일치할 때만 계속 진행
		if(passwordEncoder.matches(oldPassword, encodedPw)) {
			// 암호 인코딩
			dto.setPassword(passwordEncoder.encode(dto.getPassword()));
				
			return mapper.updateMember(dto) == 1;
		}
		return false;
	}
	
	public boolean removeMember(MemberDto member) {
		MemberDto dto = mapper.selectMemberById(member.getId());
		
		String rawPw = member.getPassword();
		String encodedPw = dto.getPassword();
		
		if(passwordEncoder.matches(rawPw, encodedPw)) {
			return mapper.deleteMemberById(member.getId()) == 1;
		}
		return false;
	}

}
