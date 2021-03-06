package com.choong.spr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.choong.spr.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

	int countMemberId(String id);

	int countMemberEmail(String email);

	int countMemberNickName(String nickName);

	List<MemberDto> selectAllMemberList();

	MemberDto selectMemberById(String id);

	int updateMember(MemberDto dto);
	
	int deleteMemberById(String id);

	int insertAuth(@Param("id") String id, @Param("auth") String auth);

	int deleteAuthById(String id);

	void updateInitPassword(@Param("id") String id, @Param("initPw") String encodedInitPassword);


}
