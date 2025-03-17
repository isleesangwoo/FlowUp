<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- multichatList.jsp --%>
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>채팅방 목록</h3>
        <button class="btn btn-primary" onclick="createNewRoom()">새 채팅방</button>
    </div>
    
    <div class="list-group">
        <c:forEach items="${chatRoomList}" var="room">
            <a href="${ctxPath}/chatting/multichat/${room.roomId}" 
               class="list-group-item list-group-item-action">
               ${room.roomName} (${room.userCount}명)
            </a>
        </c:forEach>
    </div>
</div>

<script>
function createNewRoom() {
    const roomName = prompt("채팅방 이름을 입력하세요");
    if(roomName) {
        location.href = "${ctxPath}/chatting/createRoom?roomName=" + encodeURIComponent(roomName);
    }
}
</script>