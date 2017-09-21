package com.gridsampleproject.application.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.gridsampleproject.application.model.UserInfo;

//해당 Model에 맞는 Dao가 필요. 해당 Dao에서는 관련 테이블에 대한 CRUD작업을 하는 메소드 생성//
public interface UserInfoDao extends JpaRepository<UserInfo, String>{
	 
	List<UserInfo> findAll(); //전체 select//
	
	// custom query example and return a stream
	@Query(nativeQuery = true, value="select c.user_id from userinfo c where c.user_id = :user_id")
	List<UserInfo> findByUserId(@Param("user_id") String user_id);
}