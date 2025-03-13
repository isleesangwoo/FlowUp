package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

import com.spring.app.reservation.domain.AssetReservationVO;
import com.spring.app.reservation.domain.AssetVO;

public interface ReservationService {

	// 자산 대분류를 select 해주는 메소드
	List<Map<String, String>> tbl_assetSelect();
	
	// 자산 상세를 select 해주는 메소드
	List<Map<String, String>> tbl_assetDetailSelect();
	
	// 자산 대분류를 insert 해주는 메소드
	int reservationAdd(Map<String, String> paraMap);

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

	// 대분류에 딸린 자산들을 select 해주는 메소드
	List<Map<String, String>> assetOneDeSelect(String assetNo);

	// 자산추가를 해주는 메소드
	int addAsset(Map<String, String> paraMap);

	// 해당 페이지 내의 일자 구간 예약정보 불러오기
	List<AssetReservationVO> selectassetReservationThis(AssetReservationVO assetreservationvo);

	// 예약추가를 해주는 메소드
	int addReservation(AssetReservationVO assetreservationvo);

	// 자산 소분류 삭제
	int deleteAssetNo(String assetDetailNo);

	// 상세에 해당하는 비품정보들을 불러주는 메소드
	List<Map<String, String>> selectInformation(String fk_assetdetailno);

	// 비품 하나를 삭제해주는 메소드
	int midDeleteOne(String assetInformationNo);

	// 자산 하나에 해당하는 비품들 조회하기
	List<Map<String, String>> fixSelectAssetNo(String fk_assetDetailNo);

	// 자산명을 수정해주는 메소드
	int updateAssetDetailName(Map<String, String> paraMapAsset);

	// 비품내용들을 수정해주는 메소드
	int GofixInfo(Map<String, Object> paraMapArr);

	// 회의실별 오늘에 해당하는 예약 정보 조회
	List<Map<String, String>> selectNowReservation(Map<String, Object> paraMap);

	// 예약을 삭제 해주는 메소드
	int deleteAssetReservationNo(String assetReservationNo);

	// 자산 대분류 info를 update 해주는 메소드
	int assetInfoUpdate(Map<String, String> paraMap);

	// 예약하기에 앞서 해당 일자에 예약한 건이 있는지 확인
	int selectReservation(AssetReservationVO assetreservationvo);

	// 캘린더에서 예약기능
	List<Map<String, String>> selectReservationCal(Map<String, String> map);

	

	

}
