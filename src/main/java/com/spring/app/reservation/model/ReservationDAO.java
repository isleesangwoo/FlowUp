package com.spring.app.reservation.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.reservation.domain.AssetReservationVO;
import com.spring.app.reservation.domain.AssetVO;

@Mapper //@Mapper 어노테이션을 붙여서 DAO 역할의 Mapper 인터페이스 파일을 만든다. 
		//EmpDAO 인터페이스를 구현한 DAO 클래스를 생성하면 오류가 뜨므로 절대로 DAO 클래스를 생성하면 안된다.!!! 
		//@Mapper 어노테이션을 사용하면 빈으로 등록되며 Service단에서 @Autowired 하여 사용할 수 있게 된다.
public interface ReservationDAO {

	
	// 자산 대분류를 select 해주는 메소드
	List<Map<String, String>> tbl_assetSelect();
	
	// 자산 대분류를 insert 해주는 메소드
	int reservationAdd(Map<String, String> paraMap);

	// 자산 상세를 select 해주는 메소드
	List<Map<String, String>> tbl_assetDetailSelect();

	// 내 예약 정보를 select 해주는 메소드
	List<Map<String, String>> my_Reservation(String employeeNo);

	// 대분류를 삭제하는 메소드
	int deleteAsset(String assetNo);

	// 자산 하나에 해당하는 대분류 정보를 select 해주는 메소드
	AssetVO assetOneSelect(String assetNo);

	// 대분류 하나에 해당하는 자산 정보를 select 해주는 메소드
	List<Map<String, String>> middleTapInfo(String assetNo);

	// 비품명을 추가해주는 메소드
	int addFixtures(Map<String, Object> paraMap);

	// 대분류에 딸린 소분류들을 select 해주는 메소드
	List<Map<String, String>> assetOneDeSelect(String assetNo);

	// 자산추가를 해주는 메소드
	int addAsset(Map<String, String> paraMap);

	// 해당 페이지 내의 일자 구간 예약정보 불러오기
	List<AssetReservationVO> selectassetReservationThis(AssetReservationVO assetreservationvo);

	// 예약추가를 해주는 메소드
	int addReservation(AssetReservationVO assetreservationvo);

	

}
